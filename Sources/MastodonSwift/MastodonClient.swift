import Foundation
import OAuthSwift

public typealias Scope = String
public typealias Scopes = [Scope]
public typealias Token = String

public enum MastodonClientError: Swift.Error {
    case oAuthCancelled
}

protocol MastodonClientProtocol {
    static func request(for baseURL: URL, target: TargetType, withBearerToken token: String?) throws -> URLRequest
}

extension MastodonClientProtocol {
    public static func request(for baseURL: URL, target: TargetType, withBearerToken token: String? = nil) throws -> URLRequest {
        
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(target.path), resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = target.queryItems?.map { URLQueryItem(name: $0.0, value: $0.1) }
        
        guard let url = urlComponents?.url else { throw NetworkingError.cannotCreateUrlRequest }
        
        var request = URLRequest(url: url)
        
        target.headers?.forEach { header in
            request.setValue(header.1, forHTTPHeaderField: header.0)
        }
        
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        request.httpMethod = target.method.rawValue
        request.httpBody = target.httpBody
        
        return request
    }
}

public class MastodonClient: MastodonClientProtocol {
    
    let urlSession: URLSession
    let baseURL: URL
    
    /// oAuth
    var oauthClient: OAuth2Swift?
    var oAuthHandle: OAuthSwiftRequestHandle?
    var oAuthContinuation: CheckedContinuation<OAuthSwiftCredential, Swift.Error>?
    
    public init(baseURL: URL, urlSession: URLSession = .shared) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    
    public func getAuthenticated(token: Token) -> MastodonClientAuthenticated {
        MastodonClientAuthenticated(baseURL: baseURL, urlSession: urlSession, token: token)
    }
    
    deinit {
        oAuthContinuation?.resume(throwing: MastodonClientError.oAuthCancelled)
        oAuthHandle?.cancel()
    }
}

public class MastodonClientAuthenticated: MastodonClientProtocol {
    
    private let token: Token
    private let baseURL: URL
    private let urlSession: URLSession

    init(baseURL: URL, urlSession: URLSession, token: Token) {
        self.token = token
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
        
    public func getHomeTimeline(maxId: StatusId? = nil,
                                sinceId: StatusId? = nil) async throws -> [Status] {

        let request = try Self.request(
            for: baseURL,
            target: Mastodon.Timelines.home(maxId, sinceId),
            withBearerToken: token
        )
        
        let (data, _) = try await urlSession.data(for: request)
        
        return try JSONDecoder().decode([Status].self, from: data)
    }

    public func getPublicTimeline(isLocal: Bool = false,
                                  maxId: StatusId? = nil,
                                  sinceId: StatusId? = nil) async throws -> [Status] {

        let request = try Self.request(
            for: baseURL,
            target: Mastodon.Timelines.pub(isLocal, maxId, sinceId),
            withBearerToken: token
        )
        
        let (data, _) = try await urlSession.data(for: request)
        
        return try JSONDecoder().decode([Status].self, from: data)
    }

    public func getTagTimeline(tag: String,
                               isLocal: Bool = false,
                               maxId: StatusId? = nil,
                               sinceId: StatusId? = nil) async throws -> [Status] {

        let request = try Self.request(
            for: baseURL,
            target: Mastodon.Timelines.tag(tag, isLocal, maxId, sinceId),
            withBearerToken: token
        )
        
        let (data, _) = try await urlSession.data(for: request)
        
        return try JSONDecoder().decode([Status].self, from: data)
    }
}

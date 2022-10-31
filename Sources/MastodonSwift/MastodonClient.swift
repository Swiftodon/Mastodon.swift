import Foundation

public typealias Scope = String
public typealias Scopes = [Scope]

public class MastodonClient {
    
    private let urlSession: URLSession
    private let baseURL: URL
    
    public init(baseURL: URL, urlSession: URLSession = .shared) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }

    public func createApp(_ name: String,
                          redirectUri: String = "urn:ietf:wg:oauth:2.0:oob",
                          scopes: Scopes,
                          url: URL) async throws -> App {
        
        let request = try urlSession.request(
            for: baseURL,
            target: Mastodon.Apps.register(
                name,
                redirectUri,
                scopes.reduce("") { $0 == "" ? $1 : $0 + " " + $1},
                url.absoluteString
            )
        )
        
        let (data, _) = try await urlSession.data(for: request)
        
        return try JSONDecoder().decode(App.self, from: data)
    }
    
    public func getToken(_ app: App,
                         username: String,
                         password: String,
                         scope: Scopes) async throws -> AccessToken {

        let request = try urlSession.request(
            for: baseURL,
            target: Mastodon.OAuth.authenticate(app, username, password, scope.reduce("") { $0 == "" ? $1 : $0 + " " + $1})
        )
        
        let (data, _) = try await urlSession.data(for: request)
        
        return try JSONDecoder().decode(AccessToken.self, from: data)
    }

    public func getHomeTimeline(_ token: String,
                                maxId: StatusId? = nil,
                                sinceId: StatusId? = nil) async throws -> [Status] {

        let request = try urlSession.request(
            for: baseURL,
            target: Mastodon.Timelines.home(maxId, sinceId),
            withBearerToken: token
        )
        
        let (data, _) = try await urlSession.data(for: request)
        
        return try JSONDecoder().decode([Status].self, from: data)
    }

    public func getPublicTimeline(_ token: String,
                                  isLocal: Bool = false,
                                  maxId: StatusId? = nil,
                                  sinceId: StatusId? = nil) async throws -> [Status] {

        let request = try urlSession.request(
            for: baseURL,
            target: Mastodon.Timelines.pub(isLocal, maxId, sinceId),
            withBearerToken: token
        )
        
        let (data, _) = try await urlSession.data(for: request)
        
        return try JSONDecoder().decode([Status].self, from: data)
    }

    public func getTagTimeline(_ token: String,
                               tag: String,
                               isLocal: Bool = false,
                               maxId: StatusId? = nil,
                               sinceId: StatusId? = nil) async throws -> [Status] {

        let request = try urlSession.request(
            for: baseURL,
            target: Mastodon.Timelines.tag(tag, isLocal, maxId, sinceId),
            withBearerToken: token
        )
        
        let (data, _) = try await urlSession.data(for: request)
        
        return try JSONDecoder().decode([Status].self, from: data)
    }
}

import Foundation

public typealias Scope = String
public typealias Scopes = [Scope]
public typealias Token = String

public class MastodonClient {
    
    private let urlSession: URLSession
    private let baseURL: URL
    
    public init(baseURL: URL, urlSession: URLSession = .shared) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }

    public func createApp(named name: String,
                          redirectUri: String = "urn:ietf:wg:oauth:2.0:oob",
                          scopes: Scopes,
                          website: URL) async throws -> App {
        
        let request = try urlSession.request(
            for: baseURL,
            target: Mastodon.Apps.register(
                clientName: name,
                redirectUris: redirectUri,
                scopes: scopes.reduce("") { $0 == "" ? $1 : $0 + " " + $1},
                website: website.absoluteString
            )
        )
        
        let (data, _) = try await urlSession.data(for: request)
        
        return try JSONDecoder().decode(App.self, from: data)
    }
    
    public func getToken(withApp app: App,
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
    
    public func getAuthenticated(token: Token) -> MastodonClientAuthenticated {
        MastodonClientAuthenticated(baseURL: baseURL, urlSession: urlSession, token: token)
    }
}

public class MastodonClientAuthenticated {
    
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

        let request = try urlSession.request(
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

        let request = try urlSession.request(
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

        let request = try urlSession.request(
            for: baseURL,
            target: Mastodon.Timelines.tag(tag, isLocal, maxId, sinceId),
            withBearerToken: token
        )
        
        let (data, _) = try await urlSession.data(for: request)
        
        return try JSONDecoder().decode([Status].self, from: data)
    }
}

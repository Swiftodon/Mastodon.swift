import Foundation

extension Mastodon {
    public enum Apps {
        case register(String, String, String, String)
    }
}

extension Mastodon.Apps: TargetType {
    struct Request: Encodable {
        let clientName: String
        let redirectUris: String
        let scopes: String
        let website: String
        
        enum CodingKeys: String, CodingKey {
            case clientName = "client_name"
            case redirectUris = "redirect_uris"
            case scopes
            case website
        }
        
        func encode(to encoder: Encoder) throws {
            var container: KeyedEncodingContainer<Mastodon.Apps.Request.CodingKeys> = encoder.container(keyedBy: Mastodon.Apps.Request.CodingKeys.self)
            try container.encode(self.clientName, forKey: Mastodon.Apps.Request.CodingKeys.clientName)
            try container.encode(self.redirectUris, forKey: Mastodon.Apps.Request.CodingKeys.redirectUris)
            try container.encode(self.scopes, forKey: Mastodon.Apps.Request.CodingKeys.scopes)
            try container.encode(self.website, forKey: Mastodon.Apps.Request.CodingKeys.website)
        }
    }
    
    fileprivate var apiPath: String { return "/api/v1/apps" }
    
    /// The target's base `URL`.
    public var baseURL: URL {
        return Settings.shared.baseURL!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .register(_, _, _, _):
            return "\(apiPath)"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Method {
        switch self {
        case .register(_, _, _, _):
            return .post
        }
    }
    
    /// The parameters to be incoded in the request.
    public var queryItems: [String: String]? {
        nil
    }
    
    public var headers: [String: String]? {
        [:].contentTypeApplicationJson
    }
    
    public var httpBody: Data? {
        switch self {
        case .register(let clientName, let redirectUris, let scopes, let website):
            return try? JSONEncoder().encode(
                Request(clientName: clientName, redirectUris: redirectUris, scopes: scopes, website: website)
            )
        }
    }
}

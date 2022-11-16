import Foundation

public typealias ClientId = String
public typealias ClientSecret = String
public typealias UsernameType = String
public typealias PasswordType = String

extension Mastodon {
    public enum OAuth {
        case authenticate(App, UsernameType, PasswordType, String?)
    }
}

extension Mastodon.OAuth: TargetType {
    struct Request: Encodable {
        let clientId: String
        let clientSecret: String
        let grantType: String
        let username: String
        let password: String
        let scope: String
        
        enum CodingKeys: String, CodingKey {
            case clientId = "client_id"
            case clientSecret = "client_secret"
            case grantType = "grant_type"
            case username
            case password
            case scope
        }
        
        func encode(to encoder: Encoder) throws {
            var container: KeyedEncodingContainer<Mastodon.OAuth.Request.CodingKeys> = encoder.container(keyedBy: Mastodon.OAuth.Request.CodingKeys.self)
            try container.encode(self.clientId, forKey: Mastodon.OAuth.Request.CodingKeys.clientId)
            try container.encode(self.clientSecret, forKey: Mastodon.OAuth.Request.CodingKeys.clientSecret)
            try container.encode(self.grantType, forKey: Mastodon.OAuth.Request.CodingKeys.grantType)
            try container.encode(self.username, forKey: Mastodon.OAuth.Request.CodingKeys.username)
            try container.encode(self.password, forKey: Mastodon.OAuth.Request.CodingKeys.password)
            try container.encode(self.scope, forKey: Mastodon.OAuth.Request.CodingKeys.scope)
        }
    }
    
    fileprivate var apiPath: String { return "/oauth/token" }

    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case.authenticate(_, _, _, _):
            return "\(apiPath)"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Method {
        switch self {
        case .authenticate(_, _, _, _):
            return .post
        }
    }
    
    /// The parameters to be incoded in the request.
    public var queryItems: [(String, String)]? {
        nil
    }
    
    public var headers: [String: String]? {
        [:].contentTypeApplicationJson
    }
    
    public var httpBody: Data? {
        switch self {
        case .authenticate(let app, let username, let password, let scope):
            return try? JSONEncoder().encode(
                Request(
                    clientId: app.clientId,
                    clientSecret: app.clientSecret,
                    grantType: "password",
                    username: username,
                    password: password,
                    scope: scope ?? ""
                )
            )
        }
    }
}

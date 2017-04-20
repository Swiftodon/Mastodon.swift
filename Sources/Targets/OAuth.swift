import Foundation
import Moya

public typealias ClientId = String
public typealias ClientSecret = String
public typealias UsernameType = String
public typealias PasswordType = String

extension Mastodon {
    public enum OAuth {
        case authenticate(App, UsernameType, PasswordType)
    }
}

extension Mastodon.OAuth: TargetType {
    fileprivate var apiPath: String { return "/oauth/token" }
    
    /// The target's base `URL`.
    public var baseURL: URL {
        return Settings.shared.baseURL!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case.authenticate(_, _, _):
            return "\(apiPath)"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        switch self {
        case .authenticate(_, _, _):
            return .post
        }
    }
    
    /// The parameters to be incoded in the request.
    public var parameters: [String: Any]? {
        switch self {
        case .authenticate(let app, let username, let password):
            return [
                "client_id": app.clientId,
                "client_secret": app.clientSecret,
                "grant_type": "password",
                "username": username,
                "password": password
            ]
        }
    }
    
    /// The method used for parameter encoding.
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    /// Provides stub data for use in testing.
    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    /// The type of HTTP task to be performed.
    public var task: Task {
        return .request
    }
}

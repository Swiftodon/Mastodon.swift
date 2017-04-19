import Foundation
import Moya

public typealias ClientId = String
public typealias ClientSecret = String
public typealias UsernameType = String
public typealias PasswordType = String

extension Mastodon {
    public enum OAuth {
        case authenticate(URL, App, UsernameType, PasswordType)
    }
}

extension Mastodon.OAuth: TargetType {
    /// The target's base `URL`.
    public var baseURL: URL {
        switch self {
        case .authenticate(let url, _, _, _):
            return url.appendingPathComponent("/oauth/token")
        }
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case.authenticate(_, _, _, _):
            return "/"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        switch self {
        case .authenticate(_, _, _, _):
            return .post
        }
    }
    
    /// The parameters to be incoded in the request.
    public var parameters: [String: Any]? {
        switch self {
        case .authenticate(_, let app, let username, let password):
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

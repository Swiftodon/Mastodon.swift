import Moya

typealias ClientId = String
typealias ClientSecret = String
typealias UsernameType = String
typealias PasswordType = String

extension Mastodon {
    enum OAuth {
        case authenticate(App, UsernameType, PasswordType)
    }
}

extension Mastodon.OAuth: TargetType {
    /// The target's base `URL`.
    var baseURL: URL {
        return Settings.shared.baseURL!.appendingPathComponent("/oauth/token")
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case.authenticate(_, _, _):
            return "/"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        case .authenticate(_, _, _):
            return .post
        }
    }
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
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
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        return .request
    }
}

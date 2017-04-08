import Moya

extension Mastodon {
    enum Apps {
        case register(String, String, String, String)
    }
}

extension Mastodon.Apps: TargetType {
    /// The target's base `URL`.
    var baseURL: URL {
        return Settings.shared.baseURL!.appendingPathComponent("/api/v1/apps")
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .register(_, _, _, _):
            return "/"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        case .register(_, _, _, _):
            return .post
        }
    }
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
        switch self {
        case .register(let clientName, let redirectUris, let scopes, let website):
            return [
                "client_name": clientName,
                "redirect_uris": redirectUris,
                "scopes": scopes,
                "website": website
            ]
        }
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .register(_, _, _, _):
            return URLEncoding.default
        }
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        switch self {
        case .register(_, _, _, _):
            return .request
        }
    }
}

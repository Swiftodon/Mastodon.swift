import Moya

extension Mastodon {
    enum Favourites {
        case favourites
    }
}

extension Mastodon.Favourites: TargetType {
    /// The target's base `URL`.
    var baseURL: URL {
        return Settings.shared.baseURL!.appendingPathComponent("/api/v1/favourites")
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .favourites:
            return "/"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        case .favourites:
            return .get
        }
    }
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
        switch self {
        case .favourites:
            return nil
        }
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .favourites:
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
        case .favourites:
            return .request
        }
    }
}

import Moya

extension Mastodon {
    enum Timelines {
        case home
        case pub(Bool) // Bool = local
        case tag(String, Bool) // Bool = local
    }
}

extension Mastodon.Timelines: TargetType {
    /// The target's base `URL`.
    var baseURL: URL {
        return Settings.shared.baseURL!.appendingPathComponent("/api/v1/timelines")
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .home:
            return "/home"
        case .pub(_):
            return "/public"
        case .tag(let hashtag, _):
            return "/tag/\(hashtag)"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
        switch self {
        case .pub(let local), .tag(_, let local):
            return [
                "local": local
            ]
        default:
            return nil
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

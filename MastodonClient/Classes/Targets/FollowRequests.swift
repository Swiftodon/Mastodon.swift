import Moya

extension Mastodon {
    enum FollowRequests {
        case followRequests
        case authorize(String)
        case reject(String)
    }
}

extension Mastodon.FollowRequests: TargetType {
    /// The target's base `URL`.
    var baseURL: URL {
        return Settings.shared.baseURL!.appendingPathComponent("/api/v1/follow_requests")
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .followRequests:
            return "/"
        case .authorize(_):
            return "/authorize"
        case .reject(_):
            return "/reject"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        case .followRequests:
            return .get
        case .authorize(_), .reject(_):
            return .post
        }
    }
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
        switch self {
        case .followRequests:
            return nil
        case .authorize(let id), .reject(let id):
            return [
                "id": id
            ]
        }
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
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
        default:
            return .request
        }
    }
}

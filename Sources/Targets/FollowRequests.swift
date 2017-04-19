import Foundation
import Moya

extension Mastodon {
    public enum FollowRequests {
        case followRequests(URL)
        case authorize(URL, String)
        case reject(URL, String)
    }
}

extension Mastodon.FollowRequests: TargetType {
    /// The target's base `URL`.
    public var baseURL: URL {
        switch self {
        case .followRequests(let url), .authorize(let url, _), .reject(let url, _):
            return url.appendingPathComponent("/api/v1/follow_requests")
        }
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .followRequests:
            return "/"
        case .authorize(_, _):
            return "/authorize"
        case .reject(_, _):
            return "/reject"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        switch self {
        case .followRequests:
            return .get
        case .authorize(_, _), .reject(_, _):
            return .post
        }
    }
    
    /// The parameters to be incoded in the request.
    public var parameters: [String: Any]? {
        switch self {
        case .followRequests:
            return nil
        case .authorize(_, let id), .reject(_, let id):
            return [
                "id": id
            ]
        }
    }
    
    /// The method used for parameter encoding.
    public var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    /// Provides stub data for use in testing.
    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    /// The type of HTTP task to be performed.
    public var task: Task {
        switch self {
        default:
            return .request
        }
    }
}

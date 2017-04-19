import Foundation
import Moya

extension Mastodon {
    public enum Notifications {
        case notifications(URL)
        case notification(URL, String)
        case clear(URL)
    }
}

extension Mastodon.Notifications: TargetType {
    /// The target's base `URL`.
    public var baseURL: URL {
        switch self {
        case .notifications(let url), .notification(let url, _), .clear(let url):
            return url.appendingPathComponent("/api/v1/notifications")
        }
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .notifications:
            return "/"
        case .notification(let id):
            return "/\(id)"
        case .clear:
            return "/clear"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        switch self {
        case .notifications, .notification(_, _):
            return .get
        case .clear:
            return .post
        }
    }
    
    /// The parameters to be incoded in the request.
    public var parameters: [String: Any]? {
        switch self {
        default:
            return nil
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

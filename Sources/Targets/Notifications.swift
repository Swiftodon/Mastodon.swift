import Foundation
import Moya

extension Mastodon {
    public enum Notifications {
        case notifications
        case notification(String)
        case clear
    }
}

extension Mastodon.Notifications: TargetType {
    fileprivate var apiPath: String { return "/api/v1/notifications" }

    /// The target's base `URL`.
    public var baseURL: URL {
        return Settings.shared.baseURL!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .notifications:
            return "\(apiPath)"
        case .notification(let id):
            return "\(apiPath)/\(id)"
        case .clear:
            return "\(apiPath)/clear"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        switch self {
        case .notifications, .notification(_):
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

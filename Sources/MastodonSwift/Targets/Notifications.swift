import Foundation

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
    public var method: Method {
        switch self {
        case .notifications, .notification(_):
            return .get
        case .clear:
            return .post
        }
    }
    
    /// The parameters to be incoded in the request.
    public var queryItems: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
    
    public var headers: [String: String]? {
        [:].contentTypeApplicationJson
    }
    
    public var httpBody: Data? {
        nil
    }
}

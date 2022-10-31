import Foundation

extension Mastodon {
    public enum FollowRequests {
        case followRequests
        case authorize(String)
        case reject(String)
    }
}

extension Mastodon.FollowRequests: TargetType {
    fileprivate var apiPath: String { return "/api/v1/follow_requests" }
    
    /// The target's base `URL`.
    public var baseURL: URL {
        return Settings.shared.baseURL!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .followRequests:
            return "\(apiPath)"
        case .authorize(_):
            return "\(apiPath)/authorize"
        case .reject(_):
            return "\(apiPath)/reject"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Method {
        switch self {
        case .followRequests:
            return .get
        case .authorize(_), .reject(_):
            return .post
        }
    }
    
    /// The parameters to be incoded in the request.
    public var queryItems: [String: String]? {
        nil
    }
    
    public var headers: [String: String]? {
        [:].contentTypeApplicationJson
    }
    
    public var httpBody: Data? {
        switch self {
        case .followRequests:
            return nil
        case .authorize(let id):
            return try? JSONEncoder().encode(
                ["id": id]
            )
        case .reject:
            return nil
        }
    }
}

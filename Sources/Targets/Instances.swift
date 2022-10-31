import Foundation

extension Mastodon {
    public enum Instances {
        case instance
    }
}

extension Mastodon.Instances: TargetType {
    fileprivate var apiPath: String { return "/api/v1/instance" }
    
    /// The target's base `URL`.
    public var baseURL: URL {
        return Settings.shared.baseURL!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .instance:
            return "\(apiPath)"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Method {
        switch self {
        case .instance:
            return .get
        }
    }
    
    /// The parameters to be incoded in the request.
    public var queryItems: [String: String]? {
        switch self {
        case .instance:
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

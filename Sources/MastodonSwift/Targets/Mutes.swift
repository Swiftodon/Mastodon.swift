import Foundation

extension Mastodon {
    public enum Mutes {
        case mutes
    }
}

extension Mastodon.Mutes: TargetType {
    fileprivate var apiPath: String { return "/api/v1/mutes" }

    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .mutes:
            return "\(apiPath)"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Method {
        switch self {
        case .mutes:
            return .get
        }
    }
    
    /// The parameters to be incoded in the request.
    public var queryItems: [String: String]? {
        switch self {
        case .mutes:
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

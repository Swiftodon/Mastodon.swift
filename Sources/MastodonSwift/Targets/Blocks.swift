import Foundation

extension Mastodon {
    public enum Blocks {
        case blocks
    }
}

extension Mastodon.Blocks: TargetType {
    fileprivate var apiPath: String { return "/api/v1/blocks" }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .blocks:
            return "\(apiPath)"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Method {
        switch self {
        case .blocks:
            return .get
        }
    }
    
    /// The parameters to be incoded in the request.
    public var queryItems: [String: String]? {
        switch self {
        case .blocks:
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

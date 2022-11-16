import Foundation

extension Mastodon {
    public enum Follows {
        case follow(String)
    }
}

extension Mastodon.Follows: TargetType {
    fileprivate var apiPath: String { return "/api/v1/follows" }

    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .follow(_):
            return "\(apiPath)"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Method {
        switch self {
        case .follow(_):
            return .get
        }
    }
    
    /// The parameters to be incoded in the request.
    public var queryItems: [(String, String)]? {
        nil
    }
    
    public var headers: [String: String]? {
        [:].contentTypeApplicationJson
    }
    
    public var httpBody: Data? {
        switch self {
        case .follow(let uri):
            return try? JSONEncoder().encode(
                ["uri": uri]
            )
        }
    }
}

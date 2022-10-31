import Foundation

extension Mastodon {
    public enum Search {
        case search(SearchQuery, Bool)
    }
}


extension Mastodon.Search: TargetType {
    fileprivate var apiPath: String { return "/api/v1/search" }

    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .search:
            return "\(apiPath)"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    /// The parameters to be incoded in the request.
    public var queryItems: [String: String]? {
        switch self {
        case .search(let query, let resolveNonLocal):
            return [
                "q": query,
                "resolve": resolveNonLocal.asString
            ]
        }
    }
    
    public var headers: [String: String]? {
        [:].contentTypeApplicationJson
    }
    
    public var httpBody: Data? {
        nil
    }
}

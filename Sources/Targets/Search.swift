import Foundation
import Moya

extension Mastodon {
    public enum Search {
        case search(SearchQuery, Bool)
    }
}


extension Mastodon.Search: TargetType {
    /// The target's base `URL`.
    public var baseURL: URL {
        return Settings.shared.baseURL!.appendingPathComponent("/api/v1/search")
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .search(_):
            return "/"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        switch self {
        case .search(_):
            return .get
        }
    }
    
    /// The parameters to be incoded in the request.
    public var parameters: [String: Any]? {
        switch self {
        case .search(let query, let resolveNonLocal):
            return [
                "q": query,
                "resolve": resolveNonLocal
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

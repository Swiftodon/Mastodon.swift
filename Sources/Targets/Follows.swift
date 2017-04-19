import Foundation
import Moya

extension Mastodon {
    public enum Follows {
        case follow(URL, String)
    }
}

extension Mastodon.Follows: TargetType {
    /// The target's base `URL`.
    public var baseURL: URL {
        switch self {
        case .follow(let url, _):
            return url.appendingPathComponent("/api/v1/follow_requests")
        }
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .follow(_, _):
            return "/"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        switch self {
        case .follow(_, _):
            return .get
        }
    }
    
    /// The parameters to be incoded in the request.
    public var parameters: [String: Any]? {
        switch self {
        case .follow(_, let uri):
            return [
                "uri": uri
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

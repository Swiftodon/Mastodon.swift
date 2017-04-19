import Foundation
import Moya

extension Mastodon {
    public enum Reports {
        case list(URL)
        case report(URL, String, [String], String)
    }
}

extension Mastodon.Reports: TargetType {
    /// The target's base `URL`.
    public var baseURL: URL {
        switch self {
        case .list(let url), .report(let url, _, _, _):
            return url.appendingPathComponent("/api/v1/reports")
        }
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .list, .report(_, _, _, _):
            return "/"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        switch self {
        case .list:
            return .get
        case .report(_, _, _, _):
            return .post
        }
    }
    
    /// The parameters to be incoded in the request.
    public var parameters: [String: Any]? {
        switch self {
        case .list:
            return nil
        case .report(_, let accountId, let statusIds, let comment):
            return [
                "account_id": accountId,
                "status_ids": statusIds,
                "comment": comment
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

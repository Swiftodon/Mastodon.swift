import Moya

extension Mastodon {
    enum Reports {
        case list
        case report(String, [String], String)
    }
}

extension Mastodon.Reports: TargetType {
    /// The target's base `URL`.
    var baseURL: URL {
        return Settings.shared.baseURL!.appendingPathComponent("/api/v1/reports")
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .list, .report(_, _, _):
            return "/"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        case .list:
            return .get
        case .report(_, _, _):
            return .post
        }
    }
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
        switch self {
        case .list:
            return nil
        case .report(let accountId, let statusIds, let comment):
            return [
                "account_id": accountId,
                "status_ids": statusIds,
                "comment": comment
            ]
        }
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        switch self {
        default:
            return .request
        }
    }
}

import Foundation
import Moya

public typealias SinceId = StatusId
public typealias MaxId = StatusId

extension Mastodon {
    public enum Timelines {
        case home(MaxId?, SinceId?)
        case pub(Bool, MaxId?, SinceId?) // Bool = local
        case tag(String, Bool, MaxId?, SinceId?) // Bool = local
    }
}

extension Mastodon.Timelines: TargetType {
    /// The target's base `URL`.
    public var baseURL: URL {
        return Settings.shared.baseURL!.appendingPathComponent("/api/v1/timelines")
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .home:
            return "/home"
        case .pub(_):
            return "/public"
        case .tag(let hashtag, _, _, _):
            return "/tag/\(hashtag)"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    /// The parameters to be incoded in the request.
    public var parameters: [String: Any]? {
        var params: [String : Any] = [:]
        var local: Bool? = nil
        var maxId: MaxId? = nil
        var sinceId: SinceId? = nil

        switch self {
        case .tag(_, let _local, let _maxId, let _sinceId),
             .pub(let _local, let _maxId, let _sinceId):
            local = _local
            maxId = _maxId
            sinceId = _sinceId
        case .home(let _maxId, let _sinceId):
            maxId = _maxId
            sinceId = _sinceId
        }

        if let maxId = maxId {
            params["max_id"] = maxId
        }
        if let sinceId = sinceId {
            params["since_id"] = sinceId
        }
        if let local = local {
            params["local"] = local
        }
        return params
    }
    
    /// The method used for parameter encoding.
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    /// Provides stub data for use in testing.
    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    /// The type of HTTP task to be performed.
    public var task: Task {
        return .request
    }
}

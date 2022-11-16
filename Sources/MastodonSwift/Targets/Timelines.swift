import Foundation

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
    fileprivate var apiPath: String { return "/api/v1/timelines" }

    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .home:
            return "\(apiPath)/home"
        case .pub:
            return "\(apiPath)/public"
        case .tag(let hashtag, _, _, _):
            return "\(apiPath)/tag/\(hashtag)"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Method {
        switch self {
        default:
            return .get
        }
    }
    
    /// The parameters to be incoded in the request.
    public var queryItems: [(String, String)]? {
        var params: (String, String) = ("", "")
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
            params = ("max_id",  maxId)
        }
        if let sinceId = sinceId {
            params = ("since_id", sinceId)
        }
        if let local = local {
            params = ("local", local.asString)
        }
        return [params]
    }
    
    public var headers: [String: String]? {
        [:].contentTypeApplicationJson
    }
    
    public var httpBody: Data? {
        nil
    }
}

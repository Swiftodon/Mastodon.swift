import Foundation
import Moya

extension Mastodon {
    public enum Statuses {
        public enum Visibility: String {
            case direct = "direct"
            case priv = "private"
            case unlisted = "unlisted"
            case pub = "public"
        }
        case status(String)
        case context(String)
        case card(String)
        case rebloggedBy(String)
        case favouritedBy(String)
        case new(String, String?, [String]?, Bool, String, Visibility)
        case delete(String)
        case reblog(String)
        case unreblog(String)
        case favourite(String)
        case unfavourite(String)
    }
}

extension Mastodon.Statuses: TargetType {
    fileprivate var apiPath: String { return "/api/v1/statuses" }
    
    /// The target's base `URL`.
    public var baseURL: URL {
        return Settings.shared.baseURL!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .status(let id):
            return "\(apiPath)/\(id)"
        case .context(let id):
            return "\(apiPath)/\(id)/context"
        case .card(let id):
            return "\(apiPath)/\(id)/card"
        case .rebloggedBy(let id):
            return "\(apiPath)/\(id)/reblogged_by"
        case .favouritedBy(let id):
            return "\(apiPath)/\(id)/favourited_by"
        case .new(_, _, _, _, _, _):
            return "\(apiPath)"
        case .delete(let id):
            return "\(apiPath)/\(id)"
        case .reblog(let id):
            return "\(apiPath)/\(id)/reblog"
        case .unreblog(let id):
            return "\(apiPath)/\(id)/unreblog"
        case .favourite(let id):
            return "\(apiPath)/\(id)/favourite"
        case .unfavourite(let id):
            return "\(apiPath)/\(id)/unfavourite"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        switch self {
        case .new(_, _, _, _, _, _), .reblog(_), .unreblog(_), .favourite(_), .unfavourite(_):
            return .post
        case .delete(_):
            return .delete
        default:
            return .get
        }
    }
    
    /// The parameters to be incoded in the request.
    public var parameters: [String: Any]? {
        switch self {
        case .new(let status, let inReplyToId, let mediaIds, let sensitive, let spoiler, let visibility):
            return [
                "status": status,
                "in_reply_to_id": inReplyToId ?? "", // todo: <--
                "media_ids": mediaIds ?? [],
                "sensitive": sensitive,
                "spoiler_text": spoiler,
                "visibility": visibility.rawValue
            ]
        default:
            return nil
        }
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

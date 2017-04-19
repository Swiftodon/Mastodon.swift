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
        case status(URL, String)
        case context(URL, String)
        case card(URL, String)
        case rebloggedBy(URL, String)
        case favouritedBy(URL, String)
        case new(URL, String, String?, [String]?, Bool, String, Visibility)
        case delete(URL, String)
        case reblog(URL, String)
        case unreblog(URL, String)
        case favourite(URL, String)
        case unfavourite(URL, String)
    }
}

extension Mastodon.Statuses: TargetType {
    /// The target's base `URL`.
    public var baseURL: URL {
        switch self {
        case .status(let url, _), .context(let url, _), .card(let url, _), .rebloggedBy(let url, _),
             .favouritedBy(let url, _), .new(let url, _, _, _, _, _, _),
             .delete(let url, _), .reblog(let url, _), .unreblog(let url, _), .favourite(let url, _),
             .unfavourite(let url, _):
            return url.appendingPathComponent("/api/v1/statuses")
        }
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .status(_, let id):
            return "/\(id)"
        case .context(_, let id):
            return "/\(id)/context"
        case .card(_, let id):
            return "/\(id)/card"
        case .rebloggedBy(_, let id):
            return "/\(id)/reblogged_by"
        case .favouritedBy(_, let id):
            return "/\(id)/favourited_by"
        case .new(_, _, _, _, _, _, _):
            return "/"
        case .delete(_, let id):
            return "/\(id)"
        case .reblog(_, let id):
            return "/\(id)/reblog"
        case .unreblog(_, let id):
            return "/\(id)/unreblog"
        case .favourite(_, let id):
            return "/\(id)/favourite"
        case .unfavourite(_, let id):
            return "/\(id)/unfavourite"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        switch self {
        case .new(_, _, _, _, _, _, _), .reblog(_, _), .unreblog(_, _), .favourite(_, _),
             .unfavourite(_, _):
            return .post
        case .delete(_, _):
            return .delete
        default:
            return .get
        }
    }
    
    /// The parameters to be incoded in the request.
    public var parameters: [String: Any]? {
        switch self {
        case .new(_, let status, let inReplyToId, let mediaIds, let sensitive, let spoiler, let visibility):
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

import Foundation

extension Mastodon {
    public enum Statuses {
        public enum Visibility: String, Encodable {
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
        case new(Components)
        case delete(String)
        case reblog(String)
        case unreblog(String)
        case favourite(String)
        case unfavourite(String)
        case bookmark(String)
        case unbookmark(String)
    }
}

extension Mastodon.Statuses {
    public struct Components {
        public let inReplyToId: StatusId?
        public let text: String
        public let spoilerText: String
        public let mediaIds: [String]
        public let visibility: Visibility
        public let sensitive: Bool
        public let pollOptions: [String]
        public let pollExpiresIn: Int
        public let pollMultipleChoice: Bool

        public init(
            inReplyToId: StatusId? = nil,
            text: String,
            spoilerText: String = "",
            mediaIds: [String] = [],
            visibility: Visibility = .pub,
            sensitive: Bool = false,
            pollOptions: [String] = [],
            pollExpiresIn: Int = 0,
            pollMultipleChoice: Bool = false) {
                self.inReplyToId = inReplyToId
                self.text = text
                self.spoilerText = spoilerText
                self.mediaIds = mediaIds
                self.visibility = visibility
                self.sensitive = sensitive
                self.pollOptions = pollOptions
                self.pollExpiresIn = pollExpiresIn
                self.pollMultipleChoice = pollMultipleChoice
            }
    }
}

extension Mastodon.Statuses: TargetType {
    struct Request: Encodable {
        let status: String
        let inReplyToId: String?
        let mediaIds: [String]?
        let sensitive: Bool
        let spoilerText: String?
        let visibility: Visibility
        
        enum CodingKeys: String, CodingKey {
            case status
            case inReplyToId = "in_reply_to_id"
            case mediaIds = "media_ids"
            case sensitive
            case spoilerText = "spoiler_text"
            case visibility
        }
        
        func encode(to encoder: Encoder) throws {
            var container: KeyedEncodingContainer<Mastodon.Statuses.Request.CodingKeys> = encoder.container(keyedBy: Mastodon.Statuses.Request.CodingKeys.self)
            try container.encode(self.status, forKey: Mastodon.Statuses.Request.CodingKeys.status)
            try container.encode(self.inReplyToId, forKey: Mastodon.Statuses.Request.CodingKeys.inReplyToId)
            try container.encode(self.mediaIds, forKey: Mastodon.Statuses.Request.CodingKeys.mediaIds)
            try container.encode(self.sensitive, forKey: Mastodon.Statuses.Request.CodingKeys.sensitive)
            try container.encodeIfPresent(self.spoilerText, forKey: Mastodon.Statuses.Request.CodingKeys.spoilerText)
            try container.encode(self.visibility, forKey: Mastodon.Statuses.Request.CodingKeys.visibility)
        }
    }
    
    fileprivate var apiPath: String { return "/api/v1/statuses" }

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
        case .new(_):
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
        case .bookmark(let id):
            return "\(apiPath)/\(id)/bookmark"
        case .unbookmark(let id):
            return "\(apiPath)/\(id)/unbookmark"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Method {
        switch self {
        case .new(_),
                    .reblog(_),
                    .unreblog(_),
                    .favourite(_),
                    .unfavourite(_),
                    .bookmark(_),
                    .unbookmark(_):
            return .post
        case .delete(_):
            return .delete
        default:
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
        case .new(let components):
            return try? JSONEncoder().encode(
                Request(
                    status: components.text,
                    inReplyToId: components.inReplyToId,
                    mediaIds: components.mediaIds,
                    sensitive: components.sensitive,
                    spoilerText: components.spoilerText,
                    visibility: components.visibility)
            )

        default:
            return nil
        }
    }
}

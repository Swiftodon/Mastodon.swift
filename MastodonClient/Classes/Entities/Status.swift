import Foundation
import Gloss

public typealias StatusId = Int
public typealias Html = String

public class Status: Decodable {
    public enum Visibility: String {
        case pub = "public"
        case unlisted = "unlisted"
        case priv = "private"
        case direct = "direct"
    }
    public let id: StatusId
    public let uri: String
    public let url: URL
    public let account: Account?
    public let inReplyToId: AccountId?
    public let inReplyToAccount: StatusId?
    public let reblog: Status?
    public let content: Html
    public let createdAt: String
    public let reblogsCount: Int
    public let favouritesCount: Int
    public let reblogged: Bool
    public let favourited: Bool
    public let sensitive: Bool
    public let spoilerText: String?
    public let visiblity: Visibility
    public let mediaAttachments: [Attachment]
    public let mentions: [Mention]
    public let tags: [Tag]
    public let application: Application?
    
    public required init?(json: JSON) {
        guard
            let id: Int = "id" <~~ json,
            let uri: String = "uri" <~~ json,
            let url: String = "url" <~~ json,
            let account: Account = "account" <~~ json,
            let content: Html = "content" <~~ json,
            let createdAt: String = "created_at" <~~ json,
            let visibility: String = "visibility" <~~ json
        else {
            return nil
        }
        
        self.id = id
        self.uri = uri
        self.url = URL.fromOptional(string: url)!
        self.account = account
        self.content = content
        self.createdAt = createdAt
        self.inReplyToId = "in_reply_to_id" <~~ json
        self.inReplyToAccount = "in_reply_to_account_id" <~~ json
        self.reblog = "reblog" <~~ json
        self.spoilerText = "spoiler_text" <~~ json
        self.reblogsCount = "reblogs_count" <~~ json ?? 0
        self.favouritesCount = "favourites_count" <~~ json ?? 0
        self.reblogged = "reblogged" <~~ json ?? false
        self.favourited = "favourited" <~~ json ?? false
        self.sensitive = "sensitive" <~~ json ?? false
        self.visiblity = Visibility(rawValue: visibility)!
        self.mediaAttachments = "media_attachments" <~~ json ?? []
        self.mentions = "mentions" <~~ json ?? []
        self.tags = "tags" <~~ json ?? []
        self.application = "application" <~~ json
    }
}

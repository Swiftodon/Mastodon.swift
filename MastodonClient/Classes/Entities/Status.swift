import Gloss

typealias StatusId = String
typealias Html = String

class Status: Decodable {
    enum Visibility: String {
        case pub = "public"
        case unlisted = "unlisted"
        case priv = "private"
        case direct = "direct"
    }
    let id: Int
    let uri: String
    let url: URL
    let account: Account?
    let inReplyToId: AccountId?
    let inReplyToAccount: StatusId?
    let reblog: Status?
    let content: Html
    let createdAt: String
    let reblogsCount: Int
    let favouritesCount: Int
    let reblogged: Bool
    let favourited: Bool
    let sensitive: Bool
    let spoilerText: String?
    let visiblity: Visibility
    let mediaAttachments: [Attachment]
    let mentions: [Mention]
    let tags: [Tag]
    let application: Application?
    
    required init?(json: JSON) {
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

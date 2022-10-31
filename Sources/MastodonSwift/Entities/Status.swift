import Foundation

public typealias StatusId = Int
public typealias Html = String

public class Status: Decodable {
    public enum Visibility: String, Decodable {
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

    private enum CodingKeys: String, CodingKey {
        case id
        case uri
        case url
        case account
        case inReplyToId
        case inReplyToAccount
        case reblog
        case content
        case createdAt
        case reblogsCount
        case favouritesCount
        case reblogged
        case favourited
        case sensitive
        case spoilerText
        case visiblity
        case mediaAttachments
        case mentions
        case tags
        case application
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(StatusId.self, forKey: .id)
        self.uri = try container.decode(String.self, forKey: .uri)
        self.url = try container.decode(URL.self, forKey: .url)
        self.account = try? container.decode(Account.self, forKey: .account)
        self.content = try container.decode(Html.self, forKey: .content)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.inReplyToId = try? container.decode(AccountId.self, forKey: .inReplyToId)
        self.inReplyToAccount = try? container.decode(StatusId.self, forKey: .inReplyToAccount)
        self.reblog = try? container.decode(Status.self, forKey: .reblog)
        self.spoilerText = try? container.decode(String.self, forKey: .spoilerText)
        self.reblogsCount = (try? container.decode(Int.self, forKey: .reblogsCount)) ?? 0
        self.favouritesCount = (try? container.decode(Int.self, forKey: .favouritesCount)) ?? 0
        self.reblogged = (try? container.decode(Bool.self, forKey: .reblogged)) ?? false
        self.favourited = (try? container.decode(Bool.self, forKey: .favourited)) ?? false
        self.sensitive = (try? container.decode(Bool.self, forKey: .sensitive)) ?? false
        self.visiblity = Visibility(rawValue: try container.decode(String.self, forKey: .visiblity))!
        self.mediaAttachments = (try? container.decode([Attachment].self, forKey: .mediaAttachments)) ?? []
        self.mentions = (try? container.decode([Mention].self, forKey: .mentions)) ?? []
        self.tags = (try? container.decode([Tag].self, forKey: .tags)) ?? []
        self.application = try? container.decode(Application.self, forKey: .application)
    }
}
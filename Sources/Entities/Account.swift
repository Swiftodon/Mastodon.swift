import Foundation
import Gloss

public struct Account: Decodable {
    public let id: Int
    public let username: String
    public let acct: String
    public let displayName: String?
    public let note: String?
    public let url: URL?
    public let avatar: URL?
    public let header: URL?
    public let locked: Bool
    public let createdAt: String
    public let followersCount: Int
    public let followingCount: Int
    public let statusesCount: Int
    
    public init?(json: JSON) {
        guard
            let id: Int = "id" <~~ json,
            let username: String = "username" <~~ json,
            let acct: String = "acct" <~~ json,
            let locked: Bool = "locked" <~~ json,
            let createdAt: String = "created_at" <~~ json,
            let followersCount: Int = "followers_count" <~~ json,
            let followingCount: Int = "following_count" <~~ json,
            let statusesCount: Int = "statuses_count" <~~ json
        else {
            return nil
        }
        
        self.id = id
        self.username = username
        self.acct = acct
        self.displayName = "display_name" <~~ json
        self.note = "note" <~~ json
        self.url = .fromOptional(string: "url" <~~ json)
        self.avatar = .fromOptional(string: "avatar" <~~ json)
        self.header = .fromOptional(string: "header" <~~ json)
        self.locked = locked
        self.createdAt = createdAt
        self.followersCount = followersCount
        self.followingCount = followingCount
        self.statusesCount = statusesCount
    }
}

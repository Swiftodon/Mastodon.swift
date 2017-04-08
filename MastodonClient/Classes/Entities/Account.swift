import Gloss

struct Account: Decodable {
    let id: Int
    let username: String
    let acct: String
    let displayName: String?
    let note: String?
    let url: URL?
    let avatar: URL?
    let header: URL?
    let locked: Bool
    let createdAt: String
    let followersCount: Int
    let followingCount: Int
    let statusesCount: Int
    
    init?(json: JSON) {
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

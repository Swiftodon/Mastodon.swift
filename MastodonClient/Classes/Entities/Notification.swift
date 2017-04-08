import Gloss

struct Notification: Decodable {
    enum NotificationType: String {
        case mention = "mention"
        case reblog = "reblog"
        case favourite = "favourite"
        case follow = "follow"
    }
    let id: Int
    let type: NotificationType
    let createdAt: String
    let account: Account
    let status: Status
    
    init?(json: JSON) {
        guard
            let id: Int = "id" <~~ json,
            let type: String = "type" <~~ json,
            let createdAt: String = "created_at" <~~ json,
            let account: Account = "account" <~~ json,
            let status: Status = "status" <~~ json
        else { return nil }
        
        self.id = id
        self.type = NotificationType(rawValue: type)!
        self.createdAt = createdAt
        self.account = account
        self.status = status
    }
}

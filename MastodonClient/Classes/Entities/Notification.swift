import Gloss

public struct Notification: Decodable {
    public enum NotificationType: String {
        case mention = "mention"
        case reblog = "reblog"
        case favourite = "favourite"
        case follow = "follow"
    }
    public let id: Int
    public let type: NotificationType
    public let createdAt: String
    public let account: Account
    public let status: Status
    
    public init?(json: JSON) {
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

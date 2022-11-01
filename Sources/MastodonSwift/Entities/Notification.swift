import Foundation

public struct Notification: Decodable {
    public enum NotificationType: String, Decodable {
        case mention = "mention"
        case reblog = "reblog"
        case favourite = "favourite"
        case follow = "follow"
    }
    public let id: String
    public let type: NotificationType
    public let createdAt: String
    public let account: Account
    public let status: Status

    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case createdAat = "created_at"
        case account
        case status
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.type = try container.decode(NotificationType.self, forKey: .type)
        self.createdAt = try container.decode(String.self, forKey: .createdAat)
        self.account = try container.decode(Account.self, forKey: .account)
        self.status = try container.decode(Status.self, forKey: .status)
    }
}

import Foundation

public struct Account: Codable {
    public let id: String
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
    
    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case acct
        case locked
        case createdAt = "created_at"
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case statusesCount = "statuses_count"
        case displayName
        case note
        case url
        case avatar
        case header
    }
}

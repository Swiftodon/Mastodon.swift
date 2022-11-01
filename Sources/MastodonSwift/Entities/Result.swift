import Foundation

public typealias Hashtag = String

public struct Result: Decodable {
    public let accounts: [Account]
    public let statuses: [Status]
    public let hashtags: [Hashtag]

    public enum CodingKeys: CodingKey {
        case accounts
        case statuses
        case hashtags
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accounts = (try? container.decode([Account].self, forKey: .accounts)) ?? []
        self.statuses = (try? container.decode([Status].self, forKey: .statuses)) ?? []
        self.hashtags = (try? container.decode([Hashtag].self, forKey: .hashtags)) ?? []
    }
}

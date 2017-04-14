import Gloss

public typealias Hashtag = String

public struct Result: Decodable {
    public let accounts: [Account]
    public let statuses: [Status]
    public let hashtags: [Hashtag]
    
    public init?(json: JSON) {
        accounts = "accounts" <~~ json ?? []
        statuses = "statuses" <~~ json ?? []
        hashtags = "hashtags" <~~ json ?? []
    }
}

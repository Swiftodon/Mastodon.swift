import Gloss

typealias Hashtag = String

struct Result: Decodable {
    let accounts: [Account]
    let statuses: [Status]
    let hashtags: [Hashtag]
    
    init?(json: JSON) {
        accounts = "accounts" <~~ json ?? []
        statuses = "statuses" <~~ json ?? []
        hashtags = "hashtags" <~~ json ?? []
    }
}

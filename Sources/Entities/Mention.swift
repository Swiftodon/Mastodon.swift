import Gloss

public struct Mention: Decodable {
    public let url: String
    public let username: String
    public let acct: String
    public let id: Int
    
    public init?(json: JSON) {
        guard
            let url: String = "url" <~~ json,
            let username: String = "username" <~~ json,
            let acct: String = "acct" <~~ json,
            let id: Int = "id" <~~ json
        else { return nil }
        
        self.url = url
        self.username = username
        self.acct = acct
        self.id = id
    }
}

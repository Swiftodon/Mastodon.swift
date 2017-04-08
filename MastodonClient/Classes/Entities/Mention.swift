import Gloss

struct Mention: Decodable {
    let url: String
    let username: String
    let acct: String
    let id: Int
    
    init?(json: JSON) {
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

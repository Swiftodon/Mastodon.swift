import Gloss

struct App: Decodable {
    let id: Int
    let redirectUri: String
    let clientId: String
    let clientSecret: String
    
    init?(json: JSON) {
        guard
            let id: Int = "id" <~~ json,
            let redirectUri: String = "redirect_uri" <~~ json,
            let clientId: String = "client_id" <~~ json,
            let clientSecret: String = "client_secret" <~~ json
        else { return nil }
        
        self.id = id
        self.redirectUri = redirectUri
        self.clientId = clientId
        self.clientSecret = clientSecret
    }
    
    init(clientId: String, clientSecret: String) {
        self.id = 0
        self.redirectUri = ""
        self.clientId = clientId
        self.clientSecret = clientSecret
    }
    
}

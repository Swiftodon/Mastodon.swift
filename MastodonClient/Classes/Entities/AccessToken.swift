import Gloss

struct AccessToken: Decodable {
    let token: String
    
    init?(json: JSON) {
        guard
            let token: String = "access_token" <~~ json
        else { return nil }
        self.token = token
    }
}

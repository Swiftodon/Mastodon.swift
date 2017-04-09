import Gloss

public struct AccessToken: Decodable {
    public let token: String
    
    public init?(json: JSON) {
        guard
            let token: String = "access_token" <~~ json
        else { return nil }
        self.token = token
    }
}

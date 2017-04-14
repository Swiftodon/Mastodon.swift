import Gloss

public struct Instance: Decodable {
    public let uri: String
    public let title: String?
    public let description: String?
    public let email: String?
    
    public init?(json: JSON) {
        guard
            let uri: String = "uri" <~~ json
        else { return nil }
        
        self.uri = uri
        self.title = "title" <~~ json
        self.description = "description" <~~ json
        self.email = "email" <~~ json
    }
}

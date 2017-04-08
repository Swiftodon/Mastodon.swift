import Gloss

struct Instance: Decodable {
    let uri: String
    let title: String?
    let description: String?
    let email: String?
    
    init?(json: JSON) {
        guard
            let uri: String = "uri" <~~ json
        else { return nil }
        
        self.uri = uri
        self.title = "title" <~~ json
        self.description = "description" <~~ json
        self.email = "email" <~~ json
    }
}

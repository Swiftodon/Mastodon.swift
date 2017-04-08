import Gloss

struct Application: Decodable {
    let name: String
    let website: URL?
    
    init?(json: JSON) {
        guard
            let name: String = "name" <~~ json
        else { return nil }
        
        self.name = name
        self.website = .fromOptional(string: "website" <~~ json)
    }
}

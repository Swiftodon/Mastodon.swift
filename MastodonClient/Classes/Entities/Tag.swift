import Gloss

struct Tag: Decodable {
    let name: String
    let url: URL?
    
    init?(json: JSON) {
        guard
            let name: String = "name" <~~ json
        else { return nil}
        self.name = name
        self.url = .fromOptional(string: "url" <~~ json)
    }
}

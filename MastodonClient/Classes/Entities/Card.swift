import Gloss

struct Card: Decodable {
    let url: URL?
    let title: String
    let description: String?
    let image: URL?
    
    init?(json: JSON) {
        guard
            let url: String = "url" <~~ json,
            let title: String = "title" <~~ json
        else { return nil }
        
        self.url = url.asURL()
        self.title = title
        self.description = "description" <~~ json
        self.image = .fromOptional(string: "image" <~~ json)
    }
}

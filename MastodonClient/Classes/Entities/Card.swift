import Gloss

public struct Card: Decodable {
    public let url: URL?
    public let title: String
    public let description: String?
    public let image: URL?
    
    public init?(json: JSON) {
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

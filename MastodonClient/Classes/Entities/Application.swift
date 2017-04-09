import Gloss

public struct Application: Decodable {
    public let name: String
    public let website: URL?
    
    public init?(json: JSON) {
        guard
            let name: String = "name" <~~ json
        else { return nil }
        
        self.name = name
        self.website = .fromOptional(string: "website" <~~ json)
    }
}

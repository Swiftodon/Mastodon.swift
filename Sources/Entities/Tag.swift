import Foundation
import Gloss

public struct Tag: Decodable {
    public let name: String
    public let url: URL?
    
    public init?(json: JSON) {
        guard
            let name: String = "name" <~~ json
        else { return nil}
        self.name = name
        self.url = .fromOptional(string: "url" <~~ json)
    }
}

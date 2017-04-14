import Gloss

public struct Error: Decodable {
    public let error: String
    
    public init?(json: JSON) {
        guard
            let error: String = "error" <~~ json
        else { return nil }
        self.error = error
    }
}

import Gloss

struct Error: Decodable {
    let error: String
    
    init?(json: JSON) {
        guard
            let error: String = "error" <~~ json
        else { return nil }
        self.error = error
    }
}

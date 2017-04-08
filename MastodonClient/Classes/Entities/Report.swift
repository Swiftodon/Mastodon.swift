import Gloss

struct Report: Decodable {
    let id: Int
    let actionTaken: String?
    
    init?(json: JSON) {
        guard
            let id: Int = "id" <~~ json
        else { return nil }
        
        self.id = id
        actionTaken = "action_taken" <~~ json
    }
}

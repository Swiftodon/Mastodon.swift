import Gloss

public struct Report: Decodable {
    public let id: Int
    public let actionTaken: String?
    
    public init?(json: JSON) {
        guard
            let id: Int = "id" <~~ json
        else { return nil }
        
        self.id = id
        actionTaken = "action_taken" <~~ json
    }
}

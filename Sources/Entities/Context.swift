import Gloss

public struct Context: Decodable {
    public let ancestors: [Status]
    public let descendants: [Status]
    
    public init?(json: JSON) {
        guard
            let ancestors: [Status] = "ancestors" <~~ json,
            let descendants: [Status] = "descendants" <~~ json
        else { return nil }
        
        self.ancestors = ancestors
        self.descendants = descendants
    }
}

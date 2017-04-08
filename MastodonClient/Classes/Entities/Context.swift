import Gloss

struct Context: Decodable {
    let ancestors: [Status]
    let descendants: [Status]
    
    init?(json: JSON) {
        guard
            let ancestors: [Status] = "ancestors" <~~ json,
            let descendants: [Status] = "descendants" <~~ json
        else { return nil }
        
        self.ancestors = ancestors
        self.descendants = descendants
    }
}

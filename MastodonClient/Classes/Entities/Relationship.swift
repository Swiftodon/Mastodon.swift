import Gloss

struct Relationship: Decodable {
    let following: Bool?
    let followedBy: Bool?
    let blocking: Bool?
    let muting: Bool?
    let requested: Bool?
    
    init?(json: JSON) {
        following = "following" <~~ json
        followedBy = "followedBy" <~~ json
        blocking = "blocking" <~~ json
        muting = "muting" <~~ json
        requested = "requested" <~~ json
    }
}

import Gloss

public struct Relationship: Decodable {
    public let following: Bool?
    public let followedBy: Bool?
    public let blocking: Bool?
    public let muting: Bool?
    public let requested: Bool?
    
    public init?(json: JSON) {
        following = "following" <~~ json
        followedBy = "followedBy" <~~ json
        blocking = "blocking" <~~ json
        muting = "muting" <~~ json
        requested = "requested" <~~ json
    }
}

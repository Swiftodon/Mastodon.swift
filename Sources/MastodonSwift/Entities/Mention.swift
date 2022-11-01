import Foundation

public struct Mention: Decodable {
    public let url: String
    public let username: String
    public let acct: String
    public let id: String
}

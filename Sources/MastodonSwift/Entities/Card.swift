import Foundation

public struct Card: Decodable {
    public let url: URL?
    public let title: String
    public let description: String?
    public let image: URL?
}

import Foundation

public struct Card: Codable {
    public enum CardType: String, Codable {
        case link = "link"   // Link OEmbed
        case photo = "photo" // Photo OEmbed
        case video = "video" // Video OEmbed
        case rich = "richt"  // iframe OEmbed. Not currently accepted, so won't show up in practice.
    }

    public let url: URL
    public let title: String
    public let description: String
    public let type: CardType

    public let authorName: String?
    public let authorUrl: URL?
    public let providerName: String?
    public let providerUrl: URL?
    public let html: String?
    public let width: Int?
    public let height: Int?
    public let image: URL?
    public let embedUrl: URL?
    public let blurhash: String?

    private enum CodingKeys: String, CodingKey {
        case url
        case title
        case description
        case type

        case authorName     = "author_name"
        case authorUrl      = "author_url"
        case providerName   = "provider_name"
        case providerUrl    = "provider_url"
        case html
        case width
        case height
        case image
        case embedUrl       = "embed_url"
        case blurhash
    }
}

import Foundation

public struct Instance: Codable {
    public let uri: String
    public let title: String?
    public let description: String?
    public let email: String?
    public let thumbnail: String?
    
    enum CodingKeys: CodingKey {
        case uri
        case title
        case description
        case email
        case thumbnail
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uri = try container.decode(String.self, forKey: .uri)
        self.title = try? container.decodeIfPresent(String.self, forKey: .title)
        self.description = try? container.decodeIfPresent(String.self, forKey: .description)
        self.email = try? container.decodeIfPresent(String.self, forKey: .email)
        self.thumbnail = try? container.decodeIfPresent(String.self, forKey: .thumbnail)
    }
}

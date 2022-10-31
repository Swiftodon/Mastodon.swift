import Foundation

public struct Instance: Decodable {
    public let uri: String
    public let title: String?
    public let description: String?
    public let email: String?
    
    enum CodingKeys: CodingKey {
        case uri
        case title
        case description
        case email
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uri = try container.decode(String.self, forKey: .uri)
        self.title = try? container.decodeIfPresent(String.self, forKey: .title)
        self.description = try? container.decodeIfPresent(String.self, forKey: .description)
        self.email = try? container.decodeIfPresent(String.self, forKey: .email)
    }
}

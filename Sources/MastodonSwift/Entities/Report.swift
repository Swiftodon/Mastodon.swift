import Foundation

public struct Report: Decodable {
    public let id: String
    public let actionTaken: String?

    public enum CodingKeys: CodingKey {
        case id
        case actionTaken
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.actionTaken = try? container.decodeIfPresent(String.self, forKey: .actionTaken)
    }
}

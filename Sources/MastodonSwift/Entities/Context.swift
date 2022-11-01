import Foundation

public struct Context: Decodable {
    public let ancestors: [Status]
    public let descendants: [Status]

    public enum CodingKeys: CodingKey {
        case ancestors
        case descendants
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ancestors = try container.decode([Status].self, forKey: .ancestors)
        self.descendants = try container.decode([Status].self, forKey: .descendants)
    }
}

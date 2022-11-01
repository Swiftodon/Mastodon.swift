import Foundation

public struct AccessToken: Decodable {
    public let token: String
    
    private enum CodingKeys: String, CodingKey {
        case token = "access_token"
    }
}

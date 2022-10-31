import Foundation

public struct App: Decodable {
    public let id: Int
    public let redirectUri: String
    public let clientId: String
    public let clientSecret: String

    public init(clientId: String, clientSecret: String, redirectUri: String = "urn:ietf:wg:oauth:2.0:oob") {
        self.id = 0
        self.redirectUri = redirectUri
        self.clientId = clientId
        self.clientSecret = clientSecret
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case redirectUri = "redirect_uri"
        case clientId = "client_id"
        case clientSecret = "client_secret"
    }
}

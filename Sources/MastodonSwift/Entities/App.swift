import Foundation

public struct App: Decodable {
    public let id: String
    public let name: String
    public let redirectUri: String
    public let clientId: String
    public let clientSecret: String
    public let website: String?
    public let vapidKey: String

    public init(clientId: String, clientSecret: String, vapidKey: String = "") {
        self.id = ""
        self.name = ""
        self.redirectUri = "urn:ietf:wg:oauth:2.0:oob"
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.website = nil
        self.vapidKey = vapidKey
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case redirectUri = "redirect_uri"
        case clientId = "client_id"
        case clientSecret = "client_secret"
        case website
        case vapidKey = "vapid_key"
    }
}

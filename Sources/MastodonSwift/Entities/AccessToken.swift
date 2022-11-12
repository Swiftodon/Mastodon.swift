import Foundation
import OAuthSwift

public struct AccessToken: Codable {
    public let token: String
    
    private enum CodingKeys: String, CodingKey {
        case token = "access_token"
    }
    
    #warning("This needs to be refactored, refresh token and other properties need to be available")
    public init(credential: OAuthSwiftCredential) {
        self.token = credential.oauthToken
    }
}

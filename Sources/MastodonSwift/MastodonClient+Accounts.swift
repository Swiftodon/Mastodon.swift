//
//  MastodonClient+Accounts.swift
//  
//
//  Created by Thomas Bonk on 06.11.22.
//

import Foundation

public extension MastodonClientAuthenticated {
    func verifyCredentials() async throws -> Account {
        let request = try Self.request(
            for: baseURL,
            target: Mastodon.Account.verifyCredentials,
            withBearerToken: token
        )
        
        let (data, _) = try await urlSession.data(for: request)
        
        return try JSONDecoder().decode(Account.self, from: data)
    }
}

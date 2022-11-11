//
//  MastodonClientAuthenticated+StatusActions.swift
//  
//
//  Created by Thomas Bonk on 05.11.22.
//

import Foundation

public extension MastodonClientAuthenticated {
    func boost(status: Status) async throws -> Status {
        // TODO: Check whether the current user already boosted the status
        let request = try Self.request(
            for: baseURL,
            target: Mastodon.Statuses.reblog(status.id),
            withBearerToken: token
        )
        
        let (data, _) = try await urlSession.data(for: request)
        
        return try JSONDecoder().decode(Status.self, from: data)
    }
    
    func unboost(status: Status) async throws -> Status {
        // TODO: Check whether the current user already boosted the status
        let request = try Self.request(
            for: baseURL,
            target: Mastodon.Statuses.unreblog(status.id),
            withBearerToken: token
        )
        
        let (data, _) = try await urlSession.data(for: request)
        
        return try JSONDecoder().decode(Status.self, from: data)
    }
}

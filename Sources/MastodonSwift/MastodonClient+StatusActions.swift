//
//  MastodonClientAuthenticated+StatusActions.swift
//  
//
//  Created by Thomas Bonk on 05.11.22.
//

import Foundation

public extension MastodonClientAuthenticated {
    func read(statusId: StatusId) async throws -> Status {
        let request = try Self.request(
            for: baseURL,
            target: Mastodon.Statuses.status(statusId),
            withBearerToken: token)

        let (data, _) = try await urlSession.data(for: request)

        return try JSONDecoder().decode(Status.self, from: data)
    }

    func boost(statusId: StatusId) async throws -> Status {
        // TODO: Check whether the current user already boosted the status
        let request = try Self.request(
            for: baseURL,
            target: Mastodon.Statuses.reblog(statusId),
            withBearerToken: token
        )
        
        let (data, _) = try await urlSession.data(for: request)
        
        return try JSONDecoder().decode(Status.self, from: data)
    }
    
    func unboost(statusId: StatusId) async throws -> Status {
        let request = try Self.request(
            for: baseURL,
            target: Mastodon.Statuses.unreblog(statusId),
            withBearerToken: token
        )
        
        let (data, _) = try await urlSession.data(for: request)
        
        return try JSONDecoder().decode(Status.self, from: data)
    }

    func bookmark(statusId: StatusId) async throws -> Status {
        let request = try Self.request(
            for: baseURL,
            target: Mastodon.Statuses.bookmark(statusId),
            withBearerToken: token
        )

        let (data, _) = try await urlSession.data(for: request)

        return try JSONDecoder().decode(Status.self, from: data)
    }

    func unbookmark(statusId: StatusId) async throws -> Status {
        let request = try Self.request(
            for: baseURL,
            target: Mastodon.Statuses.unbookmark(statusId),
            withBearerToken: token
        )

        let (data, _) = try await urlSession.data(for: request)

        return try JSONDecoder().decode(Status.self, from: data)
    }

    func favourite(statusId: StatusId) async throws -> Status {
        let request = try Self.request(
            for: baseURL,
            target: Mastodon.Statuses.favourite(statusId),
            withBearerToken: token
        )

        let (data, _) = try await urlSession.data(for: request)

        return try JSONDecoder().decode(Status.self, from: data)
    }

    func unfavourite(statusId: StatusId) async throws -> Status {
        let request = try Self.request(
            for: baseURL,
            target: Mastodon.Statuses.unfavourite(statusId),
            withBearerToken: token
        )

        let (data, _) = try await urlSession.data(for: request)

        return try JSONDecoder().decode(Status.self, from: data)
    }

    func new(statusComponents: Mastodon.Statuses.Components) async throws -> Status {
        let request = try Self.request(
            for: baseURL,
            target: Mastodon.Statuses.new(statusComponents),
            withBearerToken: token)

        let (data, _) = try await urlSession.data(for: request)

        return try JSONDecoder().decode(Status.self, from: data)
    }
}

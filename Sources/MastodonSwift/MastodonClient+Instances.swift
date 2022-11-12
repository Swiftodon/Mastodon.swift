//
//  File.swift
//  
//
//  Created by Thomas Bonk on 11.11.22.
//

import Foundation

public extension MastodonClient {
    func readInstanceInformation() async throws -> Instance {
        let request = try Self.request(for: baseURL, target: Mastodon.Instances.instance )
        let (data, _) = try await urlSession.data(for: request)

        return try JSONDecoder().decode(Instance.self, from: data)
    }
}

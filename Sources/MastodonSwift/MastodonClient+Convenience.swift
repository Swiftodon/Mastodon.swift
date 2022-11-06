//
//  File.swift
//  
//
//  Created by Marcus Kida on 02.11.22.
//

import Foundation
import OAuthSwift

public extension MastodonClient {
    func createApp(named name: String,
                          redirectUri: String = "urn:ietf:wg:oauth:2.0:oob",
                          scopes: Scopes,
                          website: URL) async throws -> App {
        
        let request = try Self.request(
            for: baseURL,
            target: Mastodon.Apps.register(
                clientName: name,
                redirectUris: redirectUri,
                scopes: scopes.reduce("") { $0 == "" ? $1 : $0 + " " + $1},
                website: website.absoluteString
            )
        )
        
        let (data, _) = try await urlSession.data(for: request)
        
        return try JSONDecoder().decode(App.self, from: data)
    }
    
    func authentiate(app: App, scope: Scopes) async throws -> OAuthSwiftCredential { // todo: we should not load OAuthSwift objects here
        oauthClient = OAuth2Swift(
            consumerKey: app.clientId,
            consumerSecret: app.clientSecret,
            authorizeUrl: baseURL.appendingPathComponent("oauth/authorize"),
            responseType: "token"
        )
        
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            self?.oAuthContinuation = continuation
            oAuthHandle = oauthClient?.authorize(
                withCallbackURL: app.redirectUri,
                scope: scope.asScopeString,
                state: "MASToDON_AUTH",
                completionHandler: { result in
                    switch result {
                    case let .success((credentials, response, parameters)):
                        continuation.resume(with: .success(credentials))
                    case let .failure(error):
                        continuation.resume(throwing: error)
                    }
                }
            )
        }
    }

    @available(*, deprecated, message: "The password flow is discoured and won't support 2FA. Please use authentiate(app:, scope:)")
    func getToken(withApp app: App,
                         username: String,
                         password: String,
                         scope: Scopes) async throws -> AccessToken {

        let request = try Self.request(
            for: baseURL,
            target: Mastodon.OAuth.authenticate(app, username, password, scope.asScopeString)
        )
        
        let (data, _) = try await urlSession.data(for: request)
        
        return try JSONDecoder().decode(AccessToken.self, from: data)
    }
}

private extension [String] {
    var asScopeString: String {
        joined(separator: " ")
    }
}

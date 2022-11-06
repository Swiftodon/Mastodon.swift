//
//  File.swift
//  
//
//  Created by Marcus Kida on 02.11.22.
//

import Foundation

#if os(iOS)
import UIKit
public typealias AuthenticatableViewController = UIViewController
#elseif os(macOS)
import AppKit
public typealias AuthenticatableViewController = NSViewController
#endif
import AuthenticationServices

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
    
    #if os(iOS) || os(macOS)
    func authenticate(withApp app: App, on viewController: AuthenticatableViewController) {
        let authRequest = ASAuthorizationRequest()
        let authController = ASAuthorizationController(authorizationRequests: <#T##[ASAuthorizationRequest]#>)
    }
    #endif
    
    func getToken(withApp app: App,
                         username: String,
                         password: String,
                         scope: Scopes) async throws -> AccessToken {

        let request = try Self.request(
            for: baseURL,
            target: Mastodon.OAuth.authenticate(app, username, password, scope.reduce("") { $0 == "" ? $1 : $0 + " " + $1})
        )
        
        let (data, _) = try await urlSession.data(for: request)
        
        return try JSONDecoder().decode(AccessToken.self, from: data)
    }
}

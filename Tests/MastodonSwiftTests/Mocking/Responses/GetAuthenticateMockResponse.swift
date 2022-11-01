//
//  File.swift
//  
//
//  Created by Marcus Kida on 31.10.22.
//

import Foundation

let getAuthenticateMockResponseData = "{ \"access_token\": \"s3cr3t_t0k3n\" }".data(using: .utf8)!

let getAuthenticateMockUrlResponse = HTTPURLResponse(
    url: URL(string: "https://bearologics.social/oauth/authenticate")!,
    statusCode: 200,
    httpVersion: nil,
    headerFields: nil
)!

let getAuthenticateMockResponse = (getAuthenticateMockUrlResponse, getAuthenticateMockResponseData)

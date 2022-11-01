//
//  File.swift
//  
//
//  Created by Marcus Kida on 01.11.22.
//

import Foundation

let createAppMockResponseData = """
{
  "id": "1",
  "name": "MockyMcMockface",
  "website": "https://bearologics.com",
  "redirect_uri": "urn:ietf:wg:oauth:2.0:oob",
  "client_id": "e1lVvrs0tHCsxUFvq39R2iNSqM47C7-s3cr3t",
  "client_secret": "RetkL4QT92P7N-s3cr3t_kLpEkAKadqYZr_Bgvo",
  "vapid_key": "BBM6JdtBKh4MfMVSZcOmL_USg1u3GifFw1s3cr3tQC1QKASdRx3azmJg88bxpFbAWvJh-AmtPOPbk4="
}
""".data(using: .utf8)!

let createAppMockUrlResponse = HTTPURLResponse(
    url: URL(string: "https://bearologics.social/api/v1/apps")!,
    statusCode: 200,
    httpVersion: nil,
    headerFields: nil
)!

let createAppMockResponse = (createAppMockUrlResponse, createAppMockResponseData)

import Foundation

// portion of
// curl https://bearologics.social/api/v1/instance -H "Accept: application/json"
let readInstanceInformationMockResponseData = """
{"uri":"bearologics.social","title":"Bearologics.social","short_description":"","description":"","email":"mastodon@bearologics.com","version":"4.0.2","urls":{"streaming_api":"wss://bearologics.social"},"stats":{"user_count":7,"status_count":896,"domain_count":7528},"thumbnail":"https://files.bearologics.social/site_uploads/files/000/000/001/@1x/49799467c94c92bb.png"}
""".data(using: .utf8)!

let readInstanceInformationMockUrlResponse = HTTPURLResponse(
    url: URL(string: "https://bearologics.social/api/v1/instance")!,
    statusCode: 200,
    httpVersion: nil,
    headerFields: nil
)!

let readInstanceInformationMockResponse = (readInstanceInformationMockUrlResponse, readInstanceInformationMockResponseData)

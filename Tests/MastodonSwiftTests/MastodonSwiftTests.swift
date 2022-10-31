import XCTest
@testable import MastodonSwift

class MastodonSwiftTests: XCTestCase {
    
    private var session: URLSession {
        MockURLSession.urlSession
    }
    
    func testAuthentication() async throws {
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { _ in
            getAuthenticateMockResponse
        }
        
        let client = MastodonClient(baseURL: URL(string: "https://bearologics.social")!, urlSession: session)
        
        let app = App(
            clientId: "a1a2a3a4a5",
            clientSecret: "s3cr3t"
        )
        
        let response = try await client.getToken(
            app,
            username: "test+account@host.tld",
            password: "pa4w0rd",
            scope: ["read", "write", "follow"]
        )
        
        XCTAssertEqual(response.token, "s3cr3t_t0k3n")
    }
    
    func testGetHomeTimeline() async throws {
        let token = "s3cr3t_t0k3n"
        
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { _ in
            getHomeTinelineMockResponse
        }
        
        let client = MastodonClient(baseURL: URL(string: "https://bearologics.social")!, urlSession: session)
        
        let result = try await client.getHomeTimeline(token)
        
        XCTAssertEqual(result.first?.content, "<p>TEST</p>")
    }


    static var allTests = [
        ("testAuthentication", testAuthentication),
    ]
}

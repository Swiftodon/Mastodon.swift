import XCTest
@testable import MastodonSwift

class MastodonSwiftTests: XCTestCase {
    
    private var session: URLSession {
        MockURLSession.urlSession
    }
    
    func testCreateApp() async throws {
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { _ in
            createAppMockResponse
        }
        
        let appName = "MockyMcMockface"
        
        let client = MastodonClient(baseURL: URL(string: "https://bearologics.social")!, urlSession: session)

        let response = try await client.createApp(
            named: appName,
            scopes: ["read"],
            website: URL(string: "https://bearologics.com")!)
        
        XCTAssertNotNil(response)
        XCTAssertEqual(appName, response.name)
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
            withApp: app,
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
            getHomeTimelineMockResponse
        }
        
        let client = MastodonClient(baseURL: URL(string: "https://bearologics.social")!, urlSession: session)
            .getAuthenticated(token: token)
        
        let result = try await client.getHomeTimeline()
        
        XCTAssertEqual(result.first?.content, "<p>TEST</p>")
    }
    
    func testGetHomeTimeline_withoutConvenienceMethod() async throws {
        let token = "s3cr3t_t0k3n"
        
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { _ in
            getHomeTimelineMockResponse
        }
        
        let request = try MastodonClient.request(
            for: URL(string: "https://bearologics.social")!,
            target: Mastodon.Timelines.home(nil, nil, nil, nil),
            withBearerToken: token
        )
        
        let (data, _) = try await session.data(for: request)
        
        let result = try JSONDecoder().decode([Status].self, from: data)
        
        XCTAssertEqual(result.first?.content, "<p>TEST</p>")
    }
    
    func testGetPublicTimeline() async throws {
        let token = "s3cr3t_t0k3n"
        
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { _ in
            getHomeTimelineMockResponse
        }
        
        let client = MastodonClient(baseURL: URL(string: "https://bearologics.social")!, urlSession: session)
            .getAuthenticated(token: token)

        let result = try await client.getPublicTimeline()
        
        XCTAssertEqual(result.first?.content, "<p>TEST</p>")
    }
    
    func testGetTagTimeline() async throws {
        let token = "s3cr3t_t0k3n"
        
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { _ in
            getHomeTimelineMockResponse
        }
        
        let client = MastodonClient(baseURL: URL(string: "https://bearologics.social")!, urlSession: session)
            .getAuthenticated(token: token)

        let result = try await client.getTagTimeline(tag: "TEST")
        
        XCTAssertEqual(result.first?.content, "<p>TEST</p>")
    }
    
    func testReadInstanceInformation() async throws {
        MockURLProtocol.error = nil
        MockURLProtocol.requestHandler = { _ in
            readInstanceInformationMockResponse
        }
        let client = MastodonClient(baseURL: URL(string: "https://bearologics.social")!, urlSession: session)
        let result = try await client.readInstanceInformation()
        XCTAssertEqual(result.title,"Bearologics.social")
        XCTAssertEqual(result.uri,"bearologics.social")
        XCTAssertEqual(result.email,"mastodon@bearologics.com")
        XCTAssertEqual(result.description,"")
        XCTAssertNotNil(result.thumbnail)
    }

    static var allTests = [
        ("testAuthentication", testAuthentication),
    ]
}

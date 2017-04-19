import Foundation
import Moya

extension Mastodon {
    public enum Favourites {
        case favourites(URL)
    }
}

extension Mastodon.Favourites: TargetType {
    /// The target's base `URL`.
    public var baseURL: URL {
        switch self {
        case .favourites(let url):
            return url.appendingPathComponent("/api/v1/favourites")
        }
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .favourites:
            return "/"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        switch self {
        case .favourites:
            return .get
        }
    }
    
    /// The parameters to be incoded in the request.
    public var parameters: [String: Any]? {
        switch self {
        case .favourites:
            return nil
        }
    }
    
    /// The method used for parameter encoding.
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case .favourites:
            return URLEncoding.default
        }
    }
    
    /// Provides stub data for use in testing.
    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    /// The type of HTTP task to be performed.
    public var task: Task {
        switch self {
        case .favourites:
            return .request
        }
    }
}

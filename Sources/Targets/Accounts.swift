import Foundation
import Moya

extension Mastodon {
    public enum Account {
        case account(URL, AccountId)
        case verifyCredentials(URL)
        case followers(URL, AccountId)
        case following(URL, AccountId)
        case statuses(URL, AccountId, Bool, Bool)
        case follow(URL, AccountId)
        case unfollow(URL, AccountId)
        case block(URL, AccountId)
        case unblock(URL, AccountId)
        case mute(URL, AccountId)
        case unmute(URL, AccountId)
        case relationships(URL, AccountId)
        case search(URL, SearchQuery, Int)
    }
}

extension Mastodon.Account: TargetType {
    public var baseURL: URL {
        switch self {
        case .account(let url, _), .verifyCredentials(let url), .followers(let url, _),
             .following(let url, _), .statuses(let url, _, _, _),
             .follow(let url, _), .unfollow(let url, _), .block(let url, _),
             .unblock(let url, _), .mute(let url, _), .unmute(let url, _),
             .relationships(let url, _), .search(let url, _, _):
            return url.appendingPathComponent("/api/v1/accounts")
        }
    }
    
    public var path: String {
        switch self {
        case .account(_, let id):
            return "/\(id)"
        case .verifyCredentials:
            return "/verify_credentials"
        case .followers(_, let id):
            return "/\(id)/followers"
        case .following(_, let id):
            return "/\(id)/following"
        case .statuses(_, let id, _, _):
            return "/\(id)/statuses"
        case .follow(_, let id):
            return "/\(id)/follow"
        case .unfollow(_, let id):
            return "/\(id)/unfollow"
        case .block(_, let id):
            return "/\(id)/block"
        case .unblock(_, let id):
            return "/\(id)/unblock"
        case .mute(_, let id):
            return "/\(id)/mute"
        case .unmute(_, let id):
            return "/\(id)/unmute"
        case .relationships(_, _):
            return "/relationships"
        case .search(_, _, _):
            return "/search"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .statuses(_, _, let onlyMedia, let excludeReplies):
            return [
                "only_media": onlyMedia,
                "exclude_replies": excludeReplies
            ]
        case .relationships(_, let id):
            return [
                "id": id // todo: can be array
            ]
        case .search(_, let query, let limit):
            return [
                "q": query,
                "limit": limit
            ]
        default:
            return nil
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    public var sampleData: Data {
        switch self {
        default:
            return "{}".data(using: .utf8)!
        }
    }
    
    public var task: Task {
        switch self {
        default:
            return .request
        }
    }
}

import Foundation
import Moya

extension Mastodon {
    public enum Account {
        case account(AccountId)
        case verifyCredentials
        case followers(AccountId)
        case following(AccountId)
        case statuses(AccountId, Bool, Bool)
        case follow(AccountId)
        case unfollow(AccountId)
        case block(AccountId)
        case unblock(AccountId)
        case mute(AccountId)
        case unmute(AccountId)
        case relationships(AccountId)
        case search(SearchQuery, Int)
    }
}

extension Mastodon.Account: TargetType {
    fileprivate var apiPath: String { return "/api/v1/accounts" }
    
    public var baseURL: URL {
        return Settings.shared.baseURL!
    }
    
    public var path: String {
        switch self {
        case .account(let id):
            return "\(apiPath)/\(id)"
        case .verifyCredentials:
            return "\(apiPath)/verify_credentials"
        case .followers(let id):
            return "\(apiPath)/\(id)/followers"
        case .following(let id):
            return "\(apiPath)/\(id)/following"
        case .statuses(let id, _, _):
            return "\(apiPath)/\(id)/statuses"
        case .follow(let id):
            return "\(apiPath)/\(id)/follow"
        case .unfollow(let id):
            return "\(apiPath)/\(id)/unfollow"
        case .block(let id):
            return "\(apiPath)/\(id)/block"
        case .unblock(let id):
            return "\(apiPath)/\(id)/unblock"
        case .mute(let id):
            return "\(apiPath)/\(id)/mute"
        case .unmute(let id):
            return "\(apiPath)/\(id)/unmute"
        case .relationships(_):
            return "\(apiPath)/relationships"
        case .search(_, _):
            return "\(apiPath)/search"
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
        case .statuses(_, let onlyMedia, let excludeReplies):
            return [
                "only_media": onlyMedia,
                "exclude_replies": excludeReplies
            ]
        case .relationships(let id):
            return [
                "id": id // todo: can be array
            ]
        case .search(let query, let limit):
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

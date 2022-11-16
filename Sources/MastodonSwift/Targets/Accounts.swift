import Foundation

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
    
    public var method: Method {
        switch self {
        default:
            return .get
        }
    }
        
    public var queryItems: [(String, String)]? {
        switch self {
        case .statuses(_, let onlyMedia, let excludeReplies):
            return [
                ("only_media", onlyMedia.asString),
                ("exclude_replies", excludeReplies.asString)
            ]
        case .relationships(let id):
            return [
                ("id", id) // todo: can be array
            ]
        case .search(let query, let limit):
            return [
                ("q", query),
                ("limit", limit.asString)
            ]
        default:
            return nil
        }
    }
    
    public var headers: [String: String]? {
        [:].contentTypeApplicationJson
    }
    
    public var httpBody: Data? {
        nil
    }
}

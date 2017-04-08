import Moya

extension Mastodon {
    enum Account {
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
    public var baseURL: URL {
        return Settings.shared.baseURL!.appendingPathComponent("/api/v1/accounts")
    }
    
    public var path: String {
        switch self {
        case .account(let id):
            return "/\(id)"
        case .verifyCredentials:
            return "/verify_credentials"
        case .followers(let id):
            return "/\(id)/followers"
        case .following(let id):
            return "/\(id)/following"
        case .statuses(let id, _, _):
            return "/\(id)/statuses"
        case .follow(let id):
            return "/\(id)/follow"
        case .unfollow(let id):
            return "/\(id)/unfollow"
        case .block(let id):
            return "/\(id)/block"
        case .unblock(let id):
            return "/\(id)/unblock"
        case .mute(let id):
            return "/\(id)/mute"
        case .unmute(let id):
            return "/\(id)/unmute"
        case .relationships(_):
            return "/relationships"
        case .search(_, _):
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

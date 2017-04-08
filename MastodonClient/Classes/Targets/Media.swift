import Moya

extension Mastodon {
    enum Media {
        case upload(Data)
    }
}

extension Mastodon.Media: TargetType {
    /// The target's base `URL`.
    var baseURL: URL {
        return Settings.shared.baseURL!.appendingPathComponent("/api/v1/media")
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .upload(_):
            return "/"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        case .upload(_):
            return .post
        }
    }
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
        switch self {
        case .upload(_):
            return nil
        }
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        switch self {
        case .upload(let data):
            return .upload(UploadType.multipart([
                MultipartFormData(provider: .data(data), name: "file")
            ]))
        }
    }
}

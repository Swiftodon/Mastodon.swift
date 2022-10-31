import Foundation

fileprivate let multipartBoundary = UUID().uuidString

extension Mastodon {
    public enum Media {
        case upload(Data, String)
    }
}

extension Mastodon.Media: TargetType {
    fileprivate var apiPath: String { return "/api/v1/media" }

    /// The target's base `URL`.
    public var baseURL: URL {
        return Settings.shared.baseURL!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .upload:
            return "\(apiPath)"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Method {
        switch self {
        case .upload:
            return .post
        }
    }
    
    /// The parameters to be incoded in the request.
    public var queryItems: [String: String]? {
        switch self {
        case .upload:
            return nil
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        case .upload:
            return ["content-type": "multipart/form-data; boundary=\(multipartBoundary)"]
        }
    }
    
    public var httpBody: Data? {
        switch self {
        case .upload(let data, let mimeType):
            return data.getMultipartFormDataBuilder(withBoundary: multipartBoundary)?
                .addDataField(named: "file", data: data, mimeType: mimeType)
                .build()
        }
    }
}

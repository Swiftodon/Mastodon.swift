//
//  TargetType.swift
//  MastodonSwift
//
//  Created by Marcus Kida on 31.10.22.
//

import Foundation

public enum NetworkingError: String, Swift.Error {
    case cannotCreateUrlRequest
}

public enum Method: String {
    case delete = "DELETE", get = "GET", head = "HEAD", patch = "PATCH", post = "POST", put = "PUT"
}

protocol TargetType {
        
    var baseURL: URL { get }
    var path: String { get }
    var method: Method { get }
    var headers: [String: String]? { get }
    var queryItems: [String: String]? { get }
    var httpBody: Data? { get }
}

extension URLSession {
    func request(for target: TargetType, withBearerToken token: String? = nil) throws -> URLRequest {
        
        var urlComponents = URLComponents(url: target.baseURL, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = target.queryItems?.map { URLQueryItem(name: $0.0, value: $0.1) }
        
        guard let url = urlComponents?.url else { throw NetworkingError.cannotCreateUrlRequest }
        
        var request = URLRequest(url: url)
        
        target.headers?.forEach { header in
            request.setValue(header.1, forHTTPHeaderField: header.0)
        }
        
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        request.httpMethod = target.method.rawValue
        request.httpBody = target.httpBody
        
        return request
    }
}

extension [String: String] {
    var contentTypeApplicationJson: [String: String] {
        var selfCopy = self
        selfCopy["content-type"] = "application/json"
        return selfCopy
    }
}

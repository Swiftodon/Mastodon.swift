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

public protocol TargetType {
    var path: String { get }
    var method: Method { get }
    var headers: [String: String]? { get }
    var queryItems: [(String, String)]? { get }
    var httpBody: Data? { get }
}

extension [String: String] {
    var contentTypeApplicationJson: [String: String] {
        var selfCopy = self
        selfCopy["content-type"] = "application/json"
        return selfCopy
    }
}

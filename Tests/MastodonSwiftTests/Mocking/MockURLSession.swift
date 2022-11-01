//
//  File.swift
//  
//
//  Created by Marcus Kida on 31.10.22.
//

import Foundation

enum MockURLSession {
    static var urlSession: URLSession {
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }
}


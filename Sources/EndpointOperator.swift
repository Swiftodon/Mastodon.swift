//
//  EndpointOperator.swift
//  MastodonSwift
//
//  Created by Bonk, Thomas on 20.04.17.
//
//

import Foundation
import Moya

prefix operator /
public prefix func / <T:TargetType>(url: URL) -> ((_ target: T) -> Endpoint<T>) {
    
    let endpointClosure = { (target: T) -> Endpoint<T> in
        
        return Endpoint(url: url.appendingPathComponent(target.path).absoluteString,
                        sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                        method: target.method,
                        parameters: target.parameters)
    }
    
    return endpointClosure
}

public prefix func / <T:TargetType>(url: String) -> ((_ target: T) -> Endpoint<T>) {
    
    return /URL(string: url)!
}

//
//  Bool+AsString.swift
//  MastodonSwift
//
//  Created by Marcus Kida on 31.10.22.
//

import Foundation

extension Bool {
    var asString: String {
        return self == true ? "true" : "false"
    }
}

extension Int {
    var asString: String {
        return "\(self)"
    }
}

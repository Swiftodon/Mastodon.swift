//
//  Markers.swift
//  
//
//  Created by Thomas Bonk on 15.11.22.
//

import Foundation

extension Mastodon {
    public enum Markers {
        public enum Timeline: String, Encodable {
            case home
            case notifications
        }

        case set([Timeline: StatusId])
        case read(Set<Timeline>)
    }
}

extension Mastodon.Markers: TargetType {
    fileprivate var apiPath: String { return "/api/v1/markers" }

    public var path: String {
        return apiPath
    }

    public var method: Method {
        switch self {
            case .set(_):
                return .post

            case .read(_):
                return .get
        }
    }

    public var headers: [String : String]? {
        [:].contentTypeApplicationJson
    }

    public var queryItems: [String : String]? {
        switch self {
            case .set(_):
                return nil

            case .read(let markers):
                return [
                    "timeline[]": "[\(markers.map { $0.rawValue }.joined(separator: ","))]"
                ]
        }
    }

    public var httpBody: Data? {
        switch self {
            case .set(let markers):
                let dict = Dictionary(uniqueKeysWithValues: markers.map { ($0.rawValue, ["last_read_id": $1]) })
                let data = try? JSONEncoder().encode(dict)
                return data

            case .read(_):
                return nil
        }
    }

}

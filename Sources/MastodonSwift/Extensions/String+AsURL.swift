import Foundation

extension String {
    func asURL() -> URL? {
        return URL(string: self)
    }
}

extension String {
    static let showTimeline = "ShowTimeline"
}

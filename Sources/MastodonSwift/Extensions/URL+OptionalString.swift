import Foundation

extension URL {
    static func fromOptional(string: String?) -> URL? {
        guard let string = string else {
            return nil
        }
        return URL(string: string)
    }
}

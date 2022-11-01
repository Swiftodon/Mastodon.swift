import Foundation

public struct Attachment: Decodable {
    public enum AttachmentType: String, Decodable {
        case image = "image"
        case video = "video"
        case gifv = "gifv"
    }
    
    public let id: String
    public let type: AttachmentType
    public let url: URL?
    public let remoteUrl: URL?
    public let previewUrl: URL?
    public let textUrl: URL?

    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case url
        case remoteUrl = "remote_url"
        case previewUrl = "preview_url"
        case textUrl = "text_url"
    }
}

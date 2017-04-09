import Gloss

public struct Attachment: Decodable {
    public enum AttachmentType: String {
        case image = "image"
        case video = "video"
        case gifv = "gifv"
    }
    
    public let id: Int
    public let type: AttachmentType
    public let url: URL?
    public let remoteUrl: URL?
    public let previewUrl: URL?
    public let textUrl: URL?

    public init?(json: JSON) {
        guard
            let id: Int = "id" <~~ json,
            let type: String = "type" <~~ json
        else { return nil }
        
        self.id = id
        self.type = AttachmentType(rawValue: type)! // todo: overthink as we're intentionally crashing here if the attachment is of other type
        self.url =  .fromOptional(string: "url" <~~ json)
        self.remoteUrl =  .fromOptional(string: "remote_url" <~~ json)
        self.previewUrl = .fromOptional(string: "preview_url" <~~ json)
        self.textUrl = .fromOptional(string: "text_url" <~~ json)
    }
}

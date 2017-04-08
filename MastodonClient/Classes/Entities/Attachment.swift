import Gloss

struct Attachment: Decodable {
    enum AttachmentType: String {
        case image = "image"
        case video = "video"
        case gifv = "gifv"
    }
    
    let id: Int
    let type: AttachmentType
    let url: URL?
    let remoteUrl: URL?
    let previewUrl: URL?
    let textUrl: URL?
    
    init?(json: JSON) {
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

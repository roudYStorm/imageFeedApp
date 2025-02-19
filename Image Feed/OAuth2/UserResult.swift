import Foundation

struct UserResult: Codable {
    let profileImage: Image
    
    private enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
    
    struct Image: Codable{
        let small: String
    }
}

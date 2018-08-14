// To parse the JSON, add this file to your project and do:
//
//   let giphyModel = try? JSONDecoder().decode(GiphyModel.self, from: jsonData)

import Foundation

struct GiphyModel: Codable {
    let data: [GiphyContent]?
    let pagination: Pagination?
}

struct GiphyContent: Codable {
    
    let user: User?
    let title: String?
    let previewUrl: String?
    var detailsUrl: String?
    
    private let images: [String: GiphyImages]?
    
    enum CodingKeys: String, CodingKey {
        case user, images, title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GiphyContent.CodingKeys.self)
        user = try? container.decode(User.self, forKey: .user)
        title = try? container.decode(String.self, forKey: .title)
        images = try? container.decode([String: GiphyImages].self, forKey: .images)
        previewUrl = images?["480w_stil"]?.url
        detailsUrl = images?["fixed_width"]?.url
    }
}

struct GiphyImages: Codable {
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case url
    }
}

struct User: Codable {
    let avatarURL, bannerURL, bannerImage, profileURL: String?
    let username, displayName: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case bannerURL = "banner_url"
        case bannerImage = "banner_image"
        case profileURL = "profile_url"
        case username
        case displayName = "display_name"
    }
}

struct Pagination: Codable {
    let totalCount, count, offset: Int?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count, offset
    }
}



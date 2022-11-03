//
//  ApiResponseModel.swift
//  OzeAssesment
//
//  Created by Mac on 01/11/2022.
//

import Foundation

// MARK: - Welcome
struct ApiResponse: Codable {
    let totalCount: Int?
    let items: [ItemResponse]?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

// MARK: - Item
struct ItemResponse: Codable {
    let login: String?
    let id: Int
    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?
   
    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
    }
}

struct RepoData: Codable {
    let id: Int
    let nodeID, name, fullName: String?
}

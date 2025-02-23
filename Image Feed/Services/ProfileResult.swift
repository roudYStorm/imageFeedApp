//
//  ProfileResult.swift
//  Image Feed
//
//  Created by Yulianna on 19.02.2025.
//

import Foundation
struct ProfileResult: Codable {
    var userName: String
    let firstName: String
    let lastName: String?
    var bio: String?
    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case firstName = "first_name"
        case lastName = "last_name"
        case bio
    }
}

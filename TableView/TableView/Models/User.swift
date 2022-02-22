//
//  User.swift
//  TableView
//
//  Created by Bee_MacPro on 17/02/2022.
//

import Foundation

enum Role: String, Codable {
    case unknown = "Unknown"
    case user    = "User"
    case owner   = "Owner"
    case admin   = "Admin"
    
    static func get(from: String) -> Role {
        switch from {
        case user.rawValue:
            return .user
        case owner.rawValue:
            return .owner
        case admin.rawValue:
            return .admin
        default:
            return .unknown
        }
    }
}

struct User: Codable {
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar"
        case username
        case role
    }
    
    let avatarUrl: String
    let username: String
    let role: Role
    
    init(avatarUrl: String, username: String, role: Role) {
        self.avatarUrl = avatarUrl
        self.username  = username
        self.role      = role
    }
}

//
//  UserViewModel.swift
//  TableView
//
//  Created by Bee_MacPro on 17/02/2022.
//

import Foundation

struct UserViewModel {
    let avatarUrl: String
    let username: String
    let role: Role
    let roleText: String
    
    init(user: User) {
        avatarUrl = user.avatarUrl
        username  = user.username
        role      = user.role
        roleText  = user.role.rawValue
    }
}

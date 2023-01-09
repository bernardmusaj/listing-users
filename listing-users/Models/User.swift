//
//  User.swift
//  listing-users
//
//  Created by Bernard Musaj on 4.1.23.
//

import Foundation

struct User: Identifiable {
    var id: Int = 0
    var firstName = "Demo"
    var lastName = "User"
    var email = "testuser@demo.com"
    var avatar = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png"
    
    init() {}
    
    init(_ userData: UserData) {
        id = userData.id
        firstName = userData.first_name
        lastName = userData.last_name
        email = userData.email
        avatar = userData.avatar
    }
}

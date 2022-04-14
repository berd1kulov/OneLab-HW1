//
//  User.swift
//  OneLab-HW1
//
//  Created by Bakdaulet Berdikul on 13.04.2022.
//

import Foundation

struct User {
    let name: String
    let surname: String
    let email: String
    let image: String
}

struct Mock{
    static let sampleUser = User(name: "Мария", surname: "Атрисова", email: "maria.atrisova@gmail.com", image: "profileImage")
}

//
//  User.swift
//  ToDoList
//
//  Created by Marcus Neo on 20/08/2023.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}

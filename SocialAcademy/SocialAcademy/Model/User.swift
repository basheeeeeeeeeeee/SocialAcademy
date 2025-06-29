//
//  User.swift
//  SocialAcademy
//
//  Created by Bashir Adeniran on 6/10/25.
//

struct User: Identifiable, Equatable, Codable {
    var id: String
    var name: String
}

extension User {
    static let testUser = User(id: "", name: "Jamie Harris")
}

//
//  User.swift
//  Twitty
//
//  Created by Ahmed on 11/02/2021.
//

import Foundation

struct User {
    let fullName: String
    let email: String
    let username: String
    var profileImageUrl: URL?
    let uid: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        if let profileImageUrl = dictionary["profileImageUrl"] as? String {
            guard let url = URL(string: profileImageUrl) else { return }
            self.profileImageUrl = url
        }
    }
}

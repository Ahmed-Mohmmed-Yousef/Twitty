//
//  UserServices.swift
//  Twitty
//
//  Created by Ahmed on 28/12/2020.
//

import Foundation
import FirebaseAuth

class UserServices {
    static let shared = UserServices()
    
    private init() {}
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        print("Fetch user data UID: \(uid)")
    }
}

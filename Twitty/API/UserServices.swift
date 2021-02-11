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
    
    func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        REF_USER.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String : Any] else { return }
            let user = User(uid: snapshot.key, dictionary: dictionary)
            completion(user)
        }
        
    }
}

//
//  AuthServices.swift
//  Twitty
//
//  Created by Ahmed on 27/12/2020.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullName: String
    let username: String
    let profileImage: UIImage
}

struct AuthServices {
    static let shared = AuthServices()
    
    func logUserIn(with email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(authCredentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let imageData = authCredentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        var value = [
            "email": authCredentials.email,
            "password": authCredentials.password,
            "fullName": authCredentials.fullName,
            "username": authCredentials.username,
        ]
        Auth.auth().createUser(withEmail: authCredentials.email, password: authCredentials.password) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let uid = result?.user.uid else { return }
            storageRef.putData(imageData, metadata: nil) { (meta, error) in
                storageRef.downloadURL { (url, error) in
                    guard let profileImageUrl = url?.absoluteString else { return }
                    value["profileImageUrl"] = profileImageUrl
                    REF_USER.child(uid).updateChildValues(value, withCompletionBlock: completion)
                }
            }
        }
        
    }
}

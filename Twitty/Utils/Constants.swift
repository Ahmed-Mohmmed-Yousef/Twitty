//
//  Constants.swift
//  Twitty
//
//  Created by Ahmed on 27/12/2020.
//

import Firebase

let STORAGE_REF = Storage.storage().reference().child("Twitty")
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference().child("Twitty")
let REF_USER = DB_REF.child("users")

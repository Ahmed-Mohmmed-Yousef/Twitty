//
//  TweetServices.swift
//  Twitty
//
//  Created by Ahmed on 12/02/2021.
//

import Foundation
import Firebase

class TweetServices {
    static let shared = TweetServices()
    
    private init() {}
    
    func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values: [String: Any] = [
            "uid": uid,
            "timestamp": Int(NSDate().timeIntervalSince1970),
            "likes": 0,
            "retweets": 0,
            "caption": caption
        ]
        REF_TWEET.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
}

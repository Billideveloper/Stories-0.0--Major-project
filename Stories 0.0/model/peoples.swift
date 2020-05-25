//
//  peoples.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 21/02/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Firebase

class User{
    var uid: String
    var username: String
    var email: String
    var photourl: String
    var profileImage = UIImage()
    var status: String
    var isMale: Bool?
    var age: Int?
    var latitude = ""
    var longitude = ""
    
    
    init(uids: String, usernames: String, emails: String,photourls: String,statuss: String){
        self.uid = uids
        self.username = usernames
        self.email = emails
        self.photourl = photourls
        self.status = statuss
    }
    
    static func transformuser(dict: [String: Any])  ->User?{
        guard let email = dict["UserEmail"] as? String,
        let username = dict["UserNamw"] as? String,
         let userstatus = dict["UserBio"] as? String,
         let userurl = dict["userorofileimageurl"] as? String,
            let useruid = dict["UserUniqueID"] as? String else{
                return nil
        }
        
        let user = User(uids: useruid, usernames: username, emails: email, photourls: userurl, statuss: userstatus)
        if let isMale = dict["isMale"] as? Bool{
            user.isMale = isMale
        }
        
        if let age = dict["age"] as? Int{
            user.age = age
        }
        
        if let lat = dict[LAT] as? String{
            user.latitude = lat
            
        }
        if let lon = dict[LONG] as? String{
            user.longitude = lon
        }


        return user
    }
    
}
extension User: Equatable{
    static func == (lhs: User, rhs: User) -> Bool{
        return lhs.uid == rhs.uid
    }
}

//
//  inbox.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 20/03/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import Foundation
import Firebase

class Inbox{
    var date: Double
    var text: String
    var read = false
    var user: User
  
    
    init(text: String, date: Double, user: User,read: Bool){
        self.text = text
        self.date = date
        self.read = read
        self.user = user
        
    }
    
    static func transforminbox(dict: [String: Any], user: User)  ->Inbox?{
        guard let date = dict["date"] as? Double,
        let text = dict["UserNamw"] as? String,
            let read = dict["read"] as? Bool else{
                return nil
        }
        
        let inbox = Inbox(text: text, date: date, user: user, read: read)
        
        return inbox
    }
    
}


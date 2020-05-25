//
//  Api.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 23/02/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

struct Api {
    static var  User =  userapi()
    static var Message = MessageApi()
    static var inbox = InboxApi()
    
}

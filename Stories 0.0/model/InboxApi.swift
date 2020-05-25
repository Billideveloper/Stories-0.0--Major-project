//
//  InboxApi.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 20/03/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import Foundation
import Firebase

typealias Inboxcomplition = (Inbox) -> Void


class InboxApi{
    func lastmessage(uid: String, onSucess: @escaping(Inboxcomplition) ){
        let ref = S.ref.init().databaseinboxforuser(uid: uid)
        ref.observe(DataEventType.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any>{
                Api.User.getuserinfor(uid: snapshot.key) { (user) in
                    if  let inbox = Inbox.transforminbox(dict: dict, user: user){
                        onSucess(inbox)

                    }
                                    }            }
        }
    }
    
}

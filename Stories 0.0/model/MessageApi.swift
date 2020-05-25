//
//  MessageApi().swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 25/02/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth


class MessageApi{
    
    func sendMessage(from: String, to: String, value: Dictionary<String, Any>){
        
       let ref =  S.ref.init().databasemessagesendto(from: from, to: to)
        ref.childByAutoId().updateChildValues(value)
        
        var dict = value
        if let text  = dict["text"] as? String, text.isEmpty{
            dict["imagurl"] = nil
            dict["height"] = nil
            dict["width"] = nil
        }
        
        
        let refFrom = S.ref.init().databaseInboxInFor(from: from, to: to)
        refFrom.updateChildValues(dict)
        let refTo = S.ref.init().databaseInboxInFor(from: to, to: from)
        refTo.updateChildValues(dict)
        
        
        
    }
    
    func recievedMessages(from: String, to: String, onSucess: @escaping(Message) -> Void){
        let ref = S.ref.init().databasemessagesendto(from: from, to: to)
        ref.observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any>{
                print(dict)
                if   let message = Message.transformMessage(dict: dict, keyid: snapshot.key){
                    onSucess(message)

                }
            }
        }
    }
    
}

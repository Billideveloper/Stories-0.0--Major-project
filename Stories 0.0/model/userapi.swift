//
//  userapi.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 23/02/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class userapi{
    
    var currentuserid: String{
        return Auth.auth().currentUser != nil ?
            Auth.auth().currentUser!.uid  : ""
    }
    
    
    func observeuser(onSucess: @escaping(Usercomplition)){
        
        S.ref.init().dbuser.observe(.childAdded) { (snapshot) in
                 print(snapshot.value as Any)
            
                 if let dicts = snapshot.value as? Dictionary<String, Any>{
                     if  let user = User.transformuser(dict: dicts){
                        onSucess(user)
                         
                     }
                                          
                     
                     
                 }
                 
                 
             }

        
    }
    
    func saveuserprofile(dict: Dictionary<String, Any>, onSucess: @escaping() -> Void,onErrors: @escaping(_  errormsg: String) -> Void){
        S.ref.init().dbspecificuser(uid: Api.User.currentuserid).updateChildValues(dict) { (error, dataref) in
            if error != nil{
                onErrors(error!.localizedDescription)
                return
            }
            onSucess()
        }
        
    }
    
    func getuserinfor(uid: String, onSucess: @escaping(Usercomplition) )  {
        let ref = S.ref.init().dbspecificuser(uid: uid)
        ref.observe(.value) { (snapshot) in
            if let dicts = snapshot.value as? Dictionary<String, Any>{
                if  let user = User.transformuser(dict: dicts){
                   onSucess(user)
                    
                }
                                     
                
                
            }

        }
    }
    
}
typealias Usercomplition = (User) -> Void

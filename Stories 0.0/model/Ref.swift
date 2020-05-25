//
//  Ref.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 26/02/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase
import Firebase
let STORAGE_PROFILE = "profile"
let LAT = "current_latitude"
let LONG = "current_longitude"
let profileDetail = "DetailVc"

class ref{
    // storage
    
    let storageroot = Storage.storage().reference(forURL: storagerooturl)
    
        var storageprofile: StorageReference{
        return storageroot.child(STORAGE_PROFILE)
    }
    
    var storagemessage: StorageReference{
        return storageroot.child(refmessages)
    }
    func storagespecificprofile(uid: String)  -> StorageReference{
        
        return storageprofile.child(uid)
    }
    
    func storagespecificImagemessage(id: String) -> StorageReference{
        return storagemessage.child("photo").child(id)
    }
    func storagespecificVideomessage(id: String) -> StorageReference{
        return storagemessage.child("video").child(id)
    }

}

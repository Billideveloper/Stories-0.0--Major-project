//
//  constants.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 21/01/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import Foundation

import Foundation
import FirebaseDatabase
import FirebaseStorage
import Firebase

// main home view constants are here


let refmessages = "messages"
let refinbox = "inbox"
let Geolocation = "Geofireuserlocations"

let storagerooturl = "gs://stories-0.appspot.com"

struct S {
    static let appname = "Stories"
    static let cellIdentifier = "ReusableStorycell"
    static let cellNibName = "Storiescell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    static let psellidentifier = "profilecell"
    static let pcellNibName = "profileCell"

    
    // app colors constants are here
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    // firestore constants are here
    
    struct FStore {
        static let collectionName = "Storie_Posted"
        static let userName = "name"
        static let userEmail = "email"
        static let Title = "title"
        static let subTitle = "subtitle"
        static let Imagedownloadurl = "coverImageurl"
        static let sImagedownloadurl = "storyimageurl"
        static let storyText = "storytext"
        static let storyHook = "storyhook"
        static let storydate = "storyPostedtime"
        static let storyposterProfileurl = "storyPosterURL"
        static let storysenderuid = "UserUID"
    
    }
    
    // post story constants are here
    
    struct Addstory {
        static let addTitle = "Title"
        static  let addSubtitle = "S.Title"
        static let coverImage = "C.Image"
        static let story = "Story"
        static let storyImage = "Image"
        static let storyHook = "Hook"
        
        
    }
    
    struct chat {
        static let chatsceneid = "chatscene"
        
        
    }
    
    
    struct peoples {
        static let cellid = "users"
        static let usercellidentifier = "usercell"
        
        
    }
    
    class ref {
        
        let dbroot: DatabaseReference = Database.database().reference()
        var dbuser: DatabaseReference{
            return dbroot.child(peoples.cellid)
        }
        
        func dbspecificuser(uid: String)  ->DatabaseReference{
            return dbuser.child(uid)
        }
        
        //storage
        
        var databasemessage: DatabaseReference{
            return dbroot.child(refmessages)
        }
        
        func databasemessagesendto(from: String, to: String ) -> DatabaseReference{
            return databasemessage.child(from).child(to)
        }
      
        var dataBaseInbox: DatabaseReference{
            return dbroot.child(refinbox)
        }
        
        func databaseInboxInFor(from: String, to: String ) -> DatabaseReference{
                  return dataBaseInbox.child(from).child(to)
              }
        
        func databaseinboxforuser(uid: String) -> DatabaseReference{
            return dataBaseInbox.child(uid)
        }
        
        var databasegeo: DatabaseReference{
            return dbroot.child(Geolocation)
        }
        
        
        
    }
    
    
    // user profile constants are here which are authenticated
    
    struct Userinfo {
        static let userscollection = "Authenticatedusers"
           static let name = "UserNamw"
           static  let userbio = "UserBio"
           static let useremail = "UserEmail"
           static let userimage = "userorofileimageurl"
           static let storiesposted = "storiesNumber"
        static let userconnections = "UserConnectionsnumber"
        static let useruniqueid = "UserUniqueID"
    }
    
            
        
        
        
  
    
    
    
    
}

//
//  profileController.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 25/01/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import GoogleSignIn
import Firebase

class profileController: UIViewController, UITableViewDataSource {
    
        let db = Firestore.firestore()
    
    var pstory: [DatamodelD] = [
    ]
    
    @IBOutlet weak var profileCoverimage: UIImageView!
    
    @IBOutlet weak var userprofileimage: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var useremail: UILabel!
    
    @IBOutlet weak var userBio: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    
    let currentuser = Auth.auth().currentUser?.email
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        

       updateprofile()


               
//
//        tableview.dataSource = self
//
//        tableview.register(UINib(nibName: S.pcellNibName, bundle: nil), forCellReuseIdentifier: S.psellidentifier)
//
//
//
//         loadpstories()
//        tableview.reloadData()
        
        
    }
    
    
    func loadpstories(){
        
        db.collection(S.FStore.collectionName).addSnapshotListener{ (quersnapshot, err) in
            
                    
            self.pstory = []
            
            if let e = err{
                print(e.localizedDescription)
            }else{
                
                if let snapss = quersnapshot?.documents{
                    
                    
                    for documents in snapss{
                        
                        let data = documents.data()
                        
                        
                        print("its printed here")
                            
                        print(data)
                        
                        if let ptitle = data[S.FStore.Title] as? String, let psubtitle = data[S.FStore.subTitle] as? String,
                            let pstoryurl = data[S.FStore.sImagedownloadurl] as? String,
                            let storyid = data[S.FStore.storydate] as? String,
                            let pstoryhook = data[S.FStore.storyHook] as? String{
                            print(storyid)
                            
                            
                            let pnewstory = DatamodelD(storytitle: ptitle, storysubtitle: psubtitle, storyhook: pstoryhook, storyimageurl: pstoryurl)
                            
                            self.pstory.append(pnewstory)
                            
                            DispatchQueue.main.async {
                                self.tableview.reloadData()
                            }
                            
                            
                        }
                        
                        
                        
                    }
                    
                }
                
                
            }
        }
        
        
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pstory.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let DatamodelDs = pstory[indexPath.row]
        
        let pcell = tableView.dequeueReusableCell(withIdentifier: S.psellidentifier, for: indexPath) as! profileStoriesCeill
        
        pcell.pstoryTitle.text = DatamodelDs.storytitle
        pcell.pstorySubtitle.text = DatamodelDs.storysubtitle
        pcell.pstoryhook.text = DatamodelDs.storyhook
        
        
        let pstoryimagurl = DatamodelDs.storyimageurl
        
        let purl = URL(string: pstoryimagurl)!
        let session = URLSession(configuration: .default)
        
        let download = session.dataTask(with: purl) { (data, response, error) in
            if let e = error{
                print(e.localizedDescription)
            }else{
                
                if let resp = response as? HTTPURLResponse{
                    
                    print(resp)
                    if let imagdata = data{
                        
                        let pimag = UIImage(data: imagdata)
                        
                        DispatchQueue.main.async {
                            pcell.pstoryimage.image = pimag
                        }
                    }
                    
                    
                }
                
            }
        }
        
        download.resume()
        
    
        return pcell
        
       }
  

    
    func updateprofile(){
           
           
           db.collection(S.Userinfo.userscollection).addSnapshotListener { (querysnapshots, error) in
               if let e = error{
                   print(e.localizedDescription)
               }else{
                   
                   if let snapshots = querysnapshots?.documents{
                       for docs in snapshots{
                           let  datas = docs.data()
                           
                           if let useremail = datas[S.Userinfo.useremail] as? String, let username = datas[S.Userinfo.name] as? String, let userbio = datas[S.Userinfo.userbio]  as? String, let profileurl = datas[S.Userinfo.userimage] as? String, let userconnection = datas[S.Userinfo.userconnections] as? String, let storiesposted = datas[S.Userinfo.storiesposted] as? String{
                               
                               
                               
                               if Auth.auth().currentUser?.email == useremail{
                                   
                                   self.username.text = username
                                   self.useremail.text = useremail
                                   self.userBio.text = userbio
                                   
                                   
                                   let profile = profileurl
                                   let purl = URL(string: profile)!
                                   let mysession = URLSession(configuration: .default)
                                   let pdown = mysession.dataTask(with: purl) { (data, response, error) in
                                       if let e = error{
                                           print(e.localizedDescription)
                                       }else{
                                           if let respon = response as? HTTPURLResponse{
                                               print(respon)
                                               if let pdata = data{
                                                   let primag = UIImage(data: pdata)
                                                   DispatchQueue.main.async {
                                                       self.userprofileimage.image = primag
                                                   }
                                               }
                                               
                                           }
                                       }
                                   }
                                   
                                   
                                   pdown.resume()
                            
                                   
                                   
                                   
                                   
                                   
                                   print(userconnection)
                                   print(storiesposted)
                                   
                                   
                                   
                               }
                               
                               
                               
                               
                           }
                           
                           
                           
                       }
                   }
                   
                   
               }
           }
           
           
       }
    
}

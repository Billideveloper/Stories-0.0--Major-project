//
//  ProfileController.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 26/01/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import Firebase
import GoogleSignIn

class ProfileConer: UIViewController, UITableViewDataSource {
 
    

    @IBOutlet weak var profiletableview: UITableView!
    
    
    
    
    @IBOutlet weak var userimageview: UIImageView!
    
    
    
    @IBOutlet weak var username: UILabel!
    
    
    
    
    
    let db = Firestore.firestore()
    
    
    var profiles : [Profilemodel] = [
]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
          

        loaduser()
        
        profiletableview.dataSource = self
        
        profiletableview.register(UINib(nibName: S.pcellNibName, bundle: nil), forCellReuseIdentifier: S.psellidentifier)
        
        print("profilecontroller")
        
        loadprofiles()
        
        // Do any additional setup after loading the view.
    }
    
    
    func loadprofiles(){
        
        
        db.collection(S.FStore.collectionName).getDocuments { (querysnapsho, error) in
            
            self.profiles = []
            
            if let e = error{
                print(e.localizedDescription)
            }else{
                if let quersnaps = querysnapsho?.documents{
                    
                    for doc in quersnaps{
                        let data = doc.data()
                        if let title = data[S.FStore.Title] as? String, let subtitle = data[S.FStore.subTitle] as? String, let hook = data[S.FStore.storyHook] as? String, let url = data[S.FStore.sImagedownloadurl] as? String{
                            
                            
                            
                            let newprofilecell =  Profilemodel(profiletitle: title, profilesubtitle: subtitle, profilehook: hook, profileimageurl: url)
                            
                            self.profiles.append(newprofilecell)
                            
                            DispatchQueue.main.async {
                                self.profiletableview.reloadData()
                            }
                            
                            
                            
                            
                        }
                        
                        
                    }
                    
                }
                
                
            }
        }
        
        
        
        
    }
    
    
    
    @IBAction func signmeout(_ sender: Any) {
        
        GIDSignIn.sharedInstance()?.signOut()
    
            let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            GIDSignIn.sharedInstance()?.signOut()
            self.performSegue(withIdentifier: "loginagain", sender: self)
            if Auth.auth().currentUser == nil{
                print("user is nil")
                
                self.showLoginViewController()
                
            }
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
                 
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let Profilemodels = profiles[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: S.psellidentifier, for: indexPath) as!  profileCell
        
        cell.profilecellhook.text = Profilemodels.profilehook
        cell.profilecellsubtitle.text = Profilemodels.profilesubtitle
        cell.profilecelltitle.text = Profilemodels.profiletitle
        
        
        let imagurl = Profilemodels.profileimageurl
        
        let profileurl = URL(string: imagurl)!
        let session = URLSession(configuration: .default)
        
        let download = session.dataTask(with: profileurl) { (data, response, error) in
            if let e = error{
                print(e.localizedDescription)
            }else{
                
                if let mresponse = response as?  HTTPURLResponse{
                    print(mresponse)
                    
                    if let imagdata = data{
                        
                        let imag = UIImage(data: imagdata)
                        
                        DispatchQueue.main.async {
                                                    cell.profilecellimageview.image = imag

                        }
                        
                    }
                    
                }
                
            }
        }
        download.resume()

        return cell
     }
    
    
    
    func loaduser(){
        
        
//
//        let guser = GIDSignIn.sharedInstance()?.currentUser
//        let googleuer = GIDSignIn.sharedInstance()?.currentUser
//
//
//        let imagurls = googldata!.imageURL(withDimension: 400).absoluteString
//
//        let urls = NSURL(string: imagurls)! as URL
//
//        let data = NSData(contentsOf: urls)
        
//        self.userimageview.image = UIImage(data: data! as Data)
//        self.username.text = googldata?.name
//
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

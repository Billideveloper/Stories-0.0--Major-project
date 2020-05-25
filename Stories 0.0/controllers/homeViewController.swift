//
//  homeViewController.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 18/01/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import Firebase
import GoogleSignIn


class homeViewController: UIViewController ,UITableViewDataSource{
    
    
    let db = Firestore.firestore()
    
    
    var stories : [Datamodel] = [
    ]
    
    @IBOutlet weak var tableViewStories: UITableView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
                tableViewStories.dataSource = self
        
        navigationItem.title = "Stories"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        
        tableViewStories.register(UINib(nibName: S.cellNibName, bundle: nil), forCellReuseIdentifier: S.cellIdentifier)

        
        loadStories()
        tableViewStories.reloadData()
        // Do any additional setup after loading the view.
    }
    
    
    func loadStories(){
                
        db.collection(S.FStore.collectionName).order(by: S.FStore.storydate, descending: true).addSnapshotListener { (querysnapshot, error) in
            
            
            self.stories = []

            
            if let e = error{
                print(e.localizedDescription)
            }else{
                if let snapdocs =    querysnapshot?.documents{
                    for doc in snapdocs{
                        
                        print("the data is here  ????????????????????????????????????????????????????????")
                        print(doc.data())
                        let data = doc.data()
                        
                        if let stitle = data[S.FStore.Title] as? String , let ssubtitle = data[S.FStore.subTitle] as? String,
                            let sbody = data[S.FStore.storyText] as? String, let shook = data[S.FStore.storyHook] as? String,
                            let ssender = data[S.FStore.userName] as? String, let senderemail = data[S.FStore.userEmail] as? String,
                            let coverimageurl = data[S.FStore.Imagedownloadurl] as? String, let storyimagurl = data[S.FStore.sImagedownloadurl] as? String,
                            let profileurl = data[S.FStore.storyposterProfileurl]as? String{
                            
                            
                            let newstory =  Datamodel(storytitle: stitle, storysubtitle: ssubtitle, storybody: sbody, storyhook: shook, StorysenderName: ssender, StorysenderEmail: senderemail, storycoverImageurl: coverimageurl, storyimageurl: storyimagurl,snderimagurl: profileurl)
                            
                            self.stories.append(newstory)
                            
                            DispatchQueue.main.async {
                                 self.tableViewStories.reloadData()
                            }
                            
                           
                            
                            
                            
                            
                            
                            
                        }
                        
                    }
                    
                    
                }
                
            }
        }
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stories.count
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
           
        
    
        let Datamodels = stories[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: S.cellIdentifier, for: indexPath) as! Storiescell
     
        
        
        cell.storyTitle.text = Datamodels.storytitle
               cell.storyHook.text = Datamodels.storyhook
               cell.storysubTitle.text = Datamodels.storysubtitle
               cell.story.text = Datamodels.storybody
               cell.userEmail.text = Datamodels.StorysenderEmail
               cell.userName.text = Datamodels.StorysenderName
        

    
        let mycoverurl = Datamodels.storycoverImageurl
        cell.storyCoverImage.loadImage(mycoverurl) { (coverimage) in
            cell.storyCoverImage.image = coverimage
        }
        
//        let coverpicurl = URL(string: mycoverurl)!
//        let csession = URLSession(configuration: .default)
        
        
        
        
//        let downloadpictask = csession.dataTask(with: coverpicurl) { (data, response, error) in
//            if let e = error{
//                print(e.localizedDescription)
//            }
//            else{
//                if let res = response as?  HTTPURLResponse{
//                    print(res)
//                    if let cimagdata = data{
//                        let coverimage = UIImage(data: cimagdata)
//                        DispatchQueue.main.async {
//                            cell.storyCoverImage.image = coverimage
//
//                        }
//
//                    }
//                }
//            }
//
//        }
        
        
        let mystoryimagurl = Datamodels.storyimageurl
        
        cell.storyImage.loadImage(mystoryimagurl) { (storyimage) in
            cell.storyImage.image = storyimage
        }
        
//        let storypicurl  = URL(string: mystoryimagurl)!
//        let ssessions = URLSession(configuration: .default)
        
//        let downloadmysecondpic = ssessions.dataTask(with: storypicurl) { (datas, response, error) in
//            if let e = error{
//                print(e.localizedDescription)
//            }else{
//                if let myres = response as? HTTPURLResponse{
//                    print(myres)
//
//                    if let simagdata = datas{
//
//                        let simag = UIImage(data: simagdata)
//                        DispatchQueue.main.async {
//                            cell.storyImage.image = simag
//                        }
//
//                    }
//                }
//            }
//        }
        
        
        
        
        let storysendrurl = Datamodels.snderimagurl
        cell.userProfileImage.loadImage(storysendrurl) { (userprofileimage) in
            cell.userProfileImage.image = userprofileimage
        }
        
//        let profileurl = URL(string: storysendrurl)!
//
//        let sessionses = URLSession(configuration: .default)
        
//        let downloadprofilepic = sessionses.dataTask(with: profileurl) { (pdata, presponse, perror) in
//            if let e = perror{
//                print(e.localizedDescription)
//            }else{
//                if let res = presponse as? HTTPURLResponse{
//                    print(res)
//                    if let pimgdata = pdata{
//                        let pimg = UIImage(data: pimgdata)
//                        DispatchQueue.main.async {
//                            cell.userProfileImage.image = pimg
//                        }
//                    }
//                }
//            }
//        }
        
        
//
//        downloadprofilepic.resume()
//
//
//
//        downloadmysecondpic.resume()

      
        
        
       
//
//              let cdownloadpictask = ssession.dataTask(with: storypicurl) { (datas, responses, errors) in
//                  if let e = errors{
//                      print(e.localizedDescription)
//                  }
//                  else{
//                      if let res = responses as?  HTTPURLResponse{
//                          print(res)
//                          if let cimagdata = datas{
//                              let storyimage = UIImage(data: cimagdata)
//                            DispatchQueue.main.async {
//                                  cell.storyCoverImage.image = storyimage
//                            }
//                          }
//                      }
//                  }
//
//              }
//             cdownloadpictask.resume()
        
//        downloadpictask.resume()
//
  
    
        
        
        return cell
        
        
    }
        

 
}

//
//  addStory.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 21/01/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
import Firebase
import ProgressHUD

class addStory: UIViewController {
    
    let db = Firestore.firestore()
    
    let storg = Storage.storage()
    
    let imgname = NSUUID().uuidString
    
    
    
    var imagePicker : UIImagePickerController!
    var coverpicker: UIImagePickerController!
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var storyTitle: UITextField!
    
    @IBOutlet weak var storySubtitle: UITextField!
    
    @IBOutlet weak var story: UITextView!
    
    @IBOutlet weak var storyimage: UIImageView!
    
    @IBOutlet weak var hook: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         ProgressHUD.show(" Your new story")
        navigationItem.title = "Add Story"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        story.translatesAutoresizingMaskIntoConstraints = false
             [    story.heightAnchor.constraint(equalToConstant: 100)

                 ].forEach { $0.isActive = true}
        
        
        imagePicker = UIImagePickerController()
        coverpicker = UIImagePickerController()
        coverpicker.delegate = self
                imagePicker.delegate = self
         storyTitle.isUserInteractionEnabled = false
        storySubtitle.isUserInteractionEnabled = false
        coverImage.isUserInteractionEnabled = false
        story.isUserInteractionEnabled = false
        storyimage.isUserInteractionEnabled = false
        hook.isUserInteractionEnabled = false
        
        story.delegate = self
        
        

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func add_Title(_ sender: UIButton) {
        
        let btntitle = sender.currentTitle!
       
        if btntitle == S.Addstory.addTitle{
            
            storyTitle.isUserInteractionEnabled = true
            storyTitle.becomeFirstResponder()
            
             storySubtitle.isUserInteractionEnabled = false
            coverImage.isUserInteractionEnabled = false
                   story.isUserInteractionEnabled = false
                   storyimage.isUserInteractionEnabled = false
                   hook.isUserInteractionEnabled = false
            print( btntitle)
            
        }
        
        if btntitle == S.Addstory.addSubtitle{
             print(btntitle)
            storySubtitle.isUserInteractionEnabled = true
            storySubtitle.becomeFirstResponder()
            
            storyTitle.isUserInteractionEnabled = false
            coverImage.isUserInteractionEnabled = false
            story.isUserInteractionEnabled = false
            storyimage.isUserInteractionEnabled = false
            hook.isUserInteractionEnabled = false
            
            
        }
        
        if btntitle == S.Addstory.coverImage{
            coverImage.isUserInteractionEnabled = true
            coverImage.clipsToBounds = true
            
            coverpicker.sourceType = .photoLibrary
            coverpicker.allowsEditing = true
            self.present(coverpicker, animated: true, completion: nil)
            
            
            
            
            
            story.isUserInteractionEnabled = false
                   storyimage.isUserInteractionEnabled = false
                   hook.isUserInteractionEnabled = false
            storyTitle.isUserInteractionEnabled = false
             storySubtitle.isUserInteractionEnabled = false
             print(btntitle)
            
            
            
                          
            
            
        }
        
        
        
        if btntitle == S.Addstory.story{
            story.isUserInteractionEnabled = true
            story.becomeFirstResponder()
             print(btntitle)
            
             storyTitle.isUserInteractionEnabled = false
            storySubtitle.isUserInteractionEnabled = false
            coverImage.isUserInteractionEnabled = false
            storyimage.isUserInteractionEnabled = false
                 hook.isUserInteractionEnabled = false

            
        }
        
        if btntitle == S.Addstory.storyImage{
            storyimage.isUserInteractionEnabled = true
             print(btntitle)
            storyimage.clipsToBounds = true
                     imagePicker.sourceType = .photoLibrary
                     imagePicker.allowsEditing = true
                     self.present(imagePicker, animated: true, completion: nil)
            
            storyTitle.isUserInteractionEnabled = false
                  storySubtitle.isUserInteractionEnabled = false
                  coverImage.isUserInteractionEnabled = false
                  story.isUserInteractionEnabled = false
              hook.isUserInteractionEnabled = false
            
        }
        if btntitle == S.Addstory.storyHook{
            hook.isUserInteractionEnabled = true
            hook.becomeFirstResponder()
             print(btntitle)
            storyTitle.isUserInteractionEnabled = false
                storySubtitle.isUserInteractionEnabled = false
                coverImage.isUserInteractionEnabled = false
                story.isUserInteractionEnabled = false
                storyimage.isUserInteractionEnabled = false
            
            
            
        }
        
        
        
        
    }
    
    
    
    
    
    @IBAction func share_StoryPressed(_ sender: Any) {
        
        
        
        
        let cimage = NSUUID().uuidString
              let simag = NSUUID().uuidString
              
              let cimagref = storg.reference().child("\(cimage).png")
              let simagref = storg.reference().child("\(simag).png")
        
       
              
          var datarecieved = false
        
        
              
              let cimagdata = self.coverImage.image!.pngData()
              let simagdata = self.storyimage.image!.pngData()
        
        if cimagdata == nil, simagdata == nil{
            print("please select images for your story")
        }
              
              if cimagdata != nil , simagdata != nil{
              if  let cimag = cimagdata, let simag = simagdata {
                
                // uploading storyimage to storage
                  
                  simagref.putData(simag, metadata: nil) { (metadata, error) in
                    
                      if let e = error{
                          print("im here")
                          print(e.localizedDescription)
                      }else{
                          print("sucessfully story image added")
                                      
                      }
                      
                    //uploading cover image to storage
                      
                      cimagref.putData(cimag, metadata: nil) { (metadata, error) in
                              if let e = error{
                                  print(e.localizedDescription)
                              }else{
                                  print("sucessfully added cover images")
                                                                    
                                  datarecieved = true
                                  
                                  if datarecieved == true{
                                  
                                      cimagref.downloadURL { (urlls, error) in
                                          if let e = error{
                                              print(e.localizedDescription)
                                          }else{
                                            guard let coverurls = urlls else {
                                                
                                                if let e = error{
                                                    print(e.localizedDescription)
                                                }
                                                return
                                            }
                                                                                        // Story image download url
                                            print("we are here")
                                            let coverurl  = coverurls.absoluteString
                                             print(coverurl)

                                           
                                            
                                            print("now add story image url")
                                            
                                              simagref.downloadURL { (urll, error) in
                                                                              if let e = error{
                                                                                  print(e.localizedDescription)
                                                                              }else{
                                                                                guard let downurl = urll else {
                                                                                    if let e = error{
                                                                                        print(e.localizedDescription)
                                                                                    }
                                                                                    return
                                                                                }
                                                //cover image download url
                                                                                                                    let storyimagdownloadurl = downurl.absoluteString
                                                                                                                    print(storyimagdownloadurl)
                                                                           
                                                                                  
                                                                              
                                                                               
                                                                                let storyposterid = Auth.auth().currentUser?.uid
                                               // upload data to firestore
                                                                                
                                                                                if let ssender = Auth.auth().currentUser?.displayName , let stitle = self.storyTitle.text , let ssubtitle = self.storySubtitle.text, let sty = self.story.text , let shook = self.hook.text, let semail = Auth.auth().currentUser?.email, let useruid = storyposterid,let storyposteruser = Auth.auth().currentUser?.photoURL{
                                                                                    
                                                                                                                                                                      
                                                                                                                                                            
                                                                                    let imagurl = storyposteruser.absoluteString
                                                                                                                                                              
                                                                                    
                                                                                    
                                                                                   
                                                                                    
                                                                                    
                                                                                    self.db.collection(S.FStore.collectionName).addDocument(data: [
                                                                                        S.FStore.userName: ssender,
                                                                                        S.FStore.userEmail: semail,
                                                                                        S.FStore.Title: stitle,
                                                                                        S.FStore.subTitle: ssubtitle,
                                                                                        S.FStore.storyText: sty,
                                                                                        S.FStore.storyHook: shook,
                                                                                        S.FStore.Imagedownloadurl: coverurl,
                                                                                        S.FStore.sImagedownloadurl: storyimagdownloadurl,
                                                                                        S.FStore.storydate: Date().timeIntervalSince1970,
                                                                                        S.FStore.storyposterProfileurl: imagurl,
                                                                                        S.FStore.storysenderuid: useruid
                                                                                    ]) { (error) in
                                                                                        if  let e = error{
                                                                                            print(e.localizedDescription)
                                                                                            
                                                                                        }else{
                                                                                            
                                                                                       

                                                                                            
                                                                                            
                                                                                            print("sucessfully added data ")
                                                                                            
                                                                                        }
                                                                                    }
                                                                                }
                                                                                  
                                                                                  print("done here")
                                                                                  
                                                                              }
                                                                          }
                                              
                                              
                                              
                                              
                                              
                                          }
                                      }
                                      
                                      
                                  

                                      
                                      
                                  }
                                  
                              }
                          }
                      
                      
                      
                      
                      
                      }
                  }
              }else{
                  print("there is no data")
              }
              
             
        
      
        self.dismiss(animated: true, completion: nil)


        


            
        
    }
    


}

extension addStory: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedimag = info[UIImagePickerController.InfoKey.editedImage] as?  UIImage{
            
            if picker == coverpicker{
                coverImage.image = selectedimag
            }
        else  {
            storyimage.image = selectedimag
            }
            
        }
        if let originalimg = info[UIImagePickerController.InfoKey.originalImage] as?  UIImage{
            
            if picker == coverpicker{
                coverImage.image = originalimg
            }else{
                storyimage.image = originalimg
            }
        
        }
        
        picker.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
}

extension addStory: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
         let size  = CGSize(width: view.frame.width, height: .infinity)
               
            let estimatedsize =    textView.sizeThatFits(size)
               
               textView.constraints.forEach { (constraint) in
                   if constraint.firstAttribute == .height{
                       constraint.constant = estimatedsize.height
                   }
               }
    }
    
}

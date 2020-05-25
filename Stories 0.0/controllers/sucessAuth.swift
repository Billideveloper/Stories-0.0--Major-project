//
//  sucessAuth.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 16/01/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import Firebase
import GoogleSignIn
import FirebaseAuth

class sucessAuth: UIViewController {
    
    let db = Firestore.firestore()

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var sucessNote: UILabel!
    
    
    @IBOutlet weak var continue_btn: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

        continue_btn.gradientcolor(colorOne: Colors.red, colorTwo: Colors.yello)
        
        continue_btn.layer.masksToBounds = true
        
        continue_btn.layer.cornerRadius = continue_btn.frame.size.height/2
        
        
        toggleAuthUI()

    }
    
    
    
    func toggleAuthUI() {
         if let _ = GIDSignIn.sharedInstance()?.currentUser?.authentication {
           // Signed in
        let googleuser = GIDSignIn.sharedInstance()?.currentUser
             let googledata = googleuser?.profile
             
             let imageurl = googledata!.imageURL(withDimension: 400).absoluteString
             
             let url = NSURL(string: imageurl)!  as  URL
             let data = NSData(contentsOf: url)
             self.profileImage.image = UIImage(data: data! as Data)
             
             let name = googledata?.name!
             sucessNote.text = name
            
            
          
            

       }
    }
    

    @IBAction func Contineu_btn_Pressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "homeview", sender: self)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func contineu_pressed(_ sender: Any) {
        
        
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

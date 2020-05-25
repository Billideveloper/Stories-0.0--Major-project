//
//  Mainnavigationcontroller.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 02/02/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class Mainnavigationcontroller: UINavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                         
         
            
             print(Auth.auth().currentUser as Any)
             let user = Auth.auth().currentUser
                         
                 if user != nil {
                     print("home")
              self.present(homeViewController.init(), animated: true, completion: nil)

        }else {
                    
                    self.present(ViewController.init(), animated: true, completion: nil)
                 
                    }

             
             
          }
    
    
    
    
}
        

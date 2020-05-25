//
//  ProfileTableViewController.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 21/03/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import Firebase
import GoogleSignIn
import MapKit
import CoreLocation
import ProgressHUD

class ProfileTableViewController: UITableViewController {
    
    var image: UIImage?
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userprofilepic: UIImageView!
    
    @IBOutlet weak var statuslabel: UITextField!
    @IBOutlet weak var useremail: UILabel!
    
    @IBOutlet weak var mymapview: MKMapView!
    @IBOutlet var tableview: UITableView!
    
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var ageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userprofilepic.layer.cornerRadius = 60
        
        userprofilepic.clipsToBounds = true
        observedata()
        userprofilepic.layer.borderColor = UIColor.black.cgColor
        userprofilepic.layer.borderWidth = 2
        setupview()
    
    }
    
    func setupview(){
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func observedata(){
        
    
        Api.User.getuserinfor(uid: Api.User.currentuserid) { (usr) in
            self.username.text = usr.username
            print(usr.email)
            self.useremail.text = usr.email
            self.userprofilepic.loadImage(usr.photourl)
            self.statuslabel.text = usr.status
            if let age = usr.age{
                self.ageField.text = "\(age)"
            }else{
                self.ageField.placeholder = "Optional"
                
            }
            
            let longitude = usr.longitude
            let latitude = usr.latitude
            
            if !longitude.isEmpty, !latitude.isEmpty{
                let mylocation = CLLocation(latitude: CLLocationDegrees(Double(usr.latitude)!), longitude: CLLocationDegrees(Double(usr.longitude)!))
                let annotaion = MKPointAnnotation()
                annotaion.coordinate = mylocation.coordinate
                annotaion.title = usr.username
                annotaion.subtitle = usr.email
                
                self.mymapview.addAnnotation(annotaion)
                let region = MKCoordinateRegion(center: annotaion.coordinate, latitudinalMeters: 11500, longitudinalMeters: 11500)
                self.mymapview.setRegion(region, animated: true)
            }
            
            if let isMale = usr.isMale{
                self.genderSegment.selectedSegmentIndex = (isMale == true) ?   0 : 1
                
            }
            
        }
    }

    @IBAction func logOutTapped(_ sender: Any) {

            GIDSignIn.sharedInstance()?.signOut()
        
                let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
                GIDSignIn.sharedInstance()?.signOut()
                self.performSegue(withIdentifier: "logmeout", sender: self)
                if Auth.auth().currentUser == nil{
                    print("user is nil")
                    
                    self.showLoginViewController()
                    
                }
            } catch let signOutError as NSError {
              print ("Error signing out: %@", signOutError)
            }
                     
            
        
    }
    
    // Map zoomIn function
    
    @IBAction func zoomIn(_ sender: Any) {
         var  region = MKCoordinateRegion()
         region = self.mymapview.region;
         region.span.latitudeDelta /= 2.0;
         region.span.longitudeDelta /= 2.0;
         self.mymapview.setRegion(region, animated: true)
    }
    
    // Map ZoomOut Function
    
    @IBAction func zoomOut(_ sender: Any) {
        var  region = MKCoordinateRegion()
        region = self.mymapview.region;
        region.span.latitudeDelta = min(region.span.latitudeDelta * 2.0, 180.0)
        region.span.longitudeDelta = min(region.span.longitudeDelta * 2.0, 180.0)
        
        self.mymapview.setRegion(region, animated: true)
        
    }
        
    @IBAction func savebtn_Tapped(_ sender: Any) {
        var dict = Dictionary<String, Any>()
        
        if let status = statuslabel.text, !status.isEmpty{
            dict["UserBio"] = status
            
            if genderSegment.selectedSegmentIndex == 0{
                dict["isMale"]  = true
            }
            if genderSegment.selectedSegmentIndex == 1{
                dict["isMale"] = false
            }
            
            if let age = ageField.text, !age.isEmpty{
                dict["age"] = Int(age)
                
            }
            Api.User.saveuserprofile(dict: dict, onSucess: {
                print("sucessfully updated status")
                
                ProgressHUD.showSuccess("Sucessfully saved")
                ProgressHUD.show()
                
            }) { (errormessage) in
                print(errormessage)
            }
        }
    }
    
}
    


//
//  ViewController.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 15/01/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import GoogleSignIn
import FirebaseAuth
import CoreLocation
import  ProgressHUD


class ViewController: UIViewController , GIDSignInDelegate{
    
        
    
    let manager = CLLocationManager()
    var userlati = ""
    var userlongi = ""
    
    @IBOutlet weak var googlesigninbtn: UIButton!
        
    
    override func viewDidLoad() {
        
      
              
        super.viewDidLoad()
             // Do any additional setup after loading the view.
        GoogleButton()
        configurelocationmanager()
        print("HEY YOU ARE HERE ")
    }
    
    func configurelocationmanager(){
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        manager.pausesLocationUpdatesAutomatically = true
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            manager.startUpdatingLocation()
        }
    }
    
    
    func GoogleButton() {
         
         
         GIDSignIn.sharedInstance()?.delegate = self
          GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.clientID = "1076301227019-a6necm5h6fijchgpjggkaian3eh9d3ur.apps.googleusercontent.com"

                  
     }
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let e = error{
            print(e.localizedDescription)
            
        }
        guard let authentication =  user.authentication else{
            
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            if let e = error{
                print(e.localizedDescription)
            }
            ProgressHUD.showSuccess("Sucessfullu Authenticated")
            let mySceneDelegate = self.view.window?.windowScene?.delegate
            (mySceneDelegate as! SceneDelegate).configureinitailview()
            
            if let authdata = result{
                self.createuserdatabase(authdata: authdata)
            }
            

            
        }
        

        
        
    }
    
    
    func createuserdatabase(authdata: AuthDataResult){
        
        
        let dicts:Dictionary<String, Any> = [
            
            S.Userinfo.name: authdata.user.displayName as Any,
            S.Userinfo.useremail: authdata.user.email as Any,
            S.Userinfo.userimage: (authdata.user.photoURL == nil) ? "" : authdata.user.photoURL!.absoluteString,
            S.Userinfo.storiesposted: "0",
            S.Userinfo.userconnections:"0",
            S.Userinfo.useruniqueid: authdata.user.uid
            
        ]

        
        Database.database().reference().child("users").child(authdata.user.uid).updateChildValues(dicts) { (error, refs) in
            
            
            if let e = error{
                print(e.localizedDescription)
            }else{
                print("user added to database")
            }
        }
        
        
        
    }

    
    
    

    @IBAction func signinwithgoogle(_ sender: Any) {
        
        GIDSignIn.sharedInstance()?.signIn()
    }
    
}
extension  UIViewController{
    func showLoginViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "hview") as? UITabBarController {
            viewController.modalPresentationStyle = .fullScreen
            viewController.isModalInPresentation = true
            self.present(viewController, animated: true, completion: nil)
        }
    }
 
    

}
extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse) || (status == .notDetermined){
            manager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        print("sorry can not get location")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let updatedlocation: CLLocation = locations.first!
        let newCoordinate: CLLocationCoordinate2D  = updatedlocation.coordinate
        print("your location is here")
        print(newCoordinate.latitude)
        print("can u give your location")
        print(newCoordinate.longitude)
        
        
    }
}

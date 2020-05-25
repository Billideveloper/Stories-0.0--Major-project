//
//  selectCityTableViewController.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 22/03/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit
import CoreLocation
import GeoFire
import FirebaseStorage
import Firebase
import FirebaseDatabase

class selectCityTableViewController: UITableViewController {

    @IBOutlet weak var m_p: UIButton!
    
    @IBOutlet weak var indore: UIButton!
    
    @IBOutlet weak var bhopal: UIButton!
    
    
    @IBOutlet weak var sagar: UIButton!
    
    
    @IBOutlet weak var assam: UIButton!
    
    @IBOutlet weak var banglore: UIButton!
    
    
    @IBOutlet weak var chattishgarh: UIButton!
    
    @IBOutlet weak var gujrat: UIButton!
    
    @IBOutlet weak var haryana: UIButton!
    
    
    @IBOutlet weak var himachalpradesh: UIButton!
    
    
    @IBOutlet weak var karnataka: UIButton!
    
    @IBOutlet weak var kerala: UIButton!
    
    
    @IBOutlet weak var maharashtra: UIButton!
    
    
    @IBOutlet weak var odisha: UIButton!
    
    
    @IBOutlet weak var rajasthan: UIButton!
    
    @IBOutlet weak var tamilnadu: UIButton!
    
    @IBOutlet weak var telengana: UIButton!
    
    @IBOutlet weak var u_P_: UIButton!
    
    
    @IBOutlet weak var westbenagal: UIButton!
    
    @IBOutlet weak var pune: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

    }
    
    var myLatitude = ""
    var myLongitude = ""
    var grofire: GeoFire!
    var geoFireref: DatabaseReference!
    
    
    
    
    func getmylocation(){
        
        let userdefaults : UserDefaults = UserDefaults.standard
             userdefaults.set(myLatitude, forKey: "Current_Location_Latitude")
             userdefaults.set(myLongitude, forKey: "Current_Location_Longitude")
             userdefaults.synchronize()
        
        if let userlatitude = UserDefaults.standard.value(forKey: "Current_Location_Latitude") as? String,
            let userlongitude = UserDefaults.standard.value(forKey: "Current_Location_Longitude") as? String {
            
             
            if !userlatitude.isEmpty && !userlongitude.isEmpty{
                let location: CLLocation = CLLocation(latitude: CLLocationDegrees(Double(userlatitude)!), longitude: CLLocationDegrees(Double(userlongitude)!))
                // send location to firebase
                                
                self.geoFireref = S.ref.init().databasegeo
                self.grofire = GeoFire(firebaseRef: self.geoFireref)
                self.grofire.setLocation(location, forKey: Api.User.currentuserid)
                S.ref.init().dbspecificuser(uid: Api.User.currentuserid).updateChildValues([LAT:userlatitude, LONG: userlongitude])

                

                
                
            }
            
        }

        
    }
   
    
    
    @IBAction func m_p_Selected(_ sender: Any) {
      

        myLatitude = "23.473324"
        myLongitude = "77.947998"
        
         getmylocation()
                

            
        
    }
    
    @IBAction func indoreselected(_ sender: Any) {
        
        myLatitude = "22.7196"
        myLongitude = "75.8577"
        
        getmylocation()

    }
    
    @IBAction func bhopalselected(_ sender: Any) {
        myLatitude = "23.2599"
        myLongitude = "77.4126"
        
        getmylocation()


    }
    
    @IBAction func sagarselected(_ sender: Any) {
        myLatitude = "23.8388"
        myLongitude = "78.7378"
                
        getmylocation()


    }
    
    @IBAction func assamselected(_ sender: Any) {
        myLatitude = "26.244156"
        myLongitude = "92.537842"

        getmylocation()

        

    }
    
    
    @IBAction func bangloreselected(_ sender: Any) {
        myLatitude = "12.9716"
        myLongitude = "77.5946"
       
        getmylocation()



    }
    
    
    @IBAction func chattisgarhselected(_ sender: Any) {
        myLatitude = "21.295132"
        myLongitude = "81.828232"
       
        getmylocation()



    }
    
    
    @IBAction func gujratselected(_ sender: Any) {
        myLatitude = "22.309425"
        myLongitude = "72.136230"
    
        getmylocation()



    }
    
    @IBAction func haryanaselected(_ sender: Any) {
        myLatitude = "29.065773"
        myLongitude = "76.040497"
      
        getmylocation()



    }
    
    
    
    @IBAction func himacahlpradeshselected(_ sender: Any) {
        myLatitude = "32.084206"
        myLongitude = "77.571167"
      
        getmylocation()



    }
    
    
    @IBAction func karnatakaselected(_ sender: Any) {
        myLatitude = "15.317277"
        myLongitude = "75.713890"
      
        getmylocation()



    }
    
    
    @IBAction func kerelaselected(_ sender: Any) {
        myLatitude = "10.850516"
        myLongitude = "76.271080"
        
        getmylocation()



    }
    
    
    @IBAction func maharashtraselected(_ sender: Any) {
        myLatitude = "19.601194"
        myLongitude = "75.552979"
      
        getmylocation()



    }
    
    @IBAction func odishaselected(_ sender: Any) {
        myLatitude = "20.940920"
        myLongitude = "84.803467"
  
        getmylocation()



    }
    
    
    @IBAction func rajasthanselected(_ sender: Any) {
        myLatitude = "27.391277"
        myLongitude = "73.432617"

        getmylocation()


    }
    
    @IBAction func tamilnaduselected(_ sender: Any) {
        myLatitude = "11.127123"
        myLongitude = "78.656891"
     
        getmylocation()



    }
    
    @IBAction func telenganaselected(_ sender: Any) {
        myLatitude = "17.123184"
        myLongitude = "79.208824"
    
        getmylocation()



    }
    
    @IBAction func upselected(_ sender: Any) {
        myLatitude = "28.207609"
        myLongitude = "79.826660"
    
        getmylocation()



    }
    
    @IBAction func westbengalselected(_ sender: Any) {
        myLatitude = "22.978624"
        myLongitude = "87.747803"
       
        getmylocation()



    }
    
    
    @IBAction func puneselected(_ sender: Any) {
        myLatitude = "18.5204"
        myLongitude = "73.8567"
       
        getmylocation()



    }
    
    func saveloactiontofirebase(){
        
        
    }
    
    
    
}

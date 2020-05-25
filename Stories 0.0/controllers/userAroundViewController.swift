//
//  userAroundViewController.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 26/03/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit
import CoreLocation
import ProgressHUD
import GeoFire



class userAroundViewController: UIViewController , CLLocationManagerDelegate{

    
    let manager = CLLocationManager()
    var userlatitude = ""
    var userlongitude = ""
//    let myslider =  UISlider()
    let distancelabel = UILabel()
    
    var geofire:GeoFire!
    var geofireref: DatabaseReference!
    
    var myquerry: GFQuery!
    var distances: Double = 500
    var users: [User] = []
    var querhandle: DatabaseHandle?
    var currentuserlocation: CLLocation?
    
    
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    @IBOutlet weak var segment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionview.delegate = self
        collectionview.dataSource = self
        
        configuremanager()
        setupNavigation()
        // Do any additional setup after loading the view.
    }
    
    func getuser(){
        if querhandle != nil , myquerry != nil{
            myquerry.removeObserver(withFirebaseHandle: querhandle!)
            myquerry = nil
            querhandle = nil
        }
        guard let userlatitde = UserDefaults.standard.value(forKey: "latest_latitude") as? String, let userlngitude = UserDefaults.standard.value(forKey: "latest_longitude") as? String else{
            return
        }
        let location: CLLocation = CLLocation(latitude: CLLocationDegrees(Double(userlatitde)!), longitude: CLLocationDegrees(Double(userlngitude)!))
        
        self.users.removeAll()
        myquerry = geofire.query(at: location, withRadius: distances)
        
       querhandle =  myquerry.observe(GFEventType.keyEntered,  with:{(keys, location) in
            
//            self.geofireref.observeSingleEvent(of: .value) { (snapshot) in
//                guard let arr = snapshot.value as? [CLLocationDegrees] else {
//                    return
//                }
//                if arr.count > 1{
//                    let lattitude = arr[0]
//                    print(lattitude)
//                    let longitude = arr[1]
//                    print(longitude)
//
//                    print("here are my latitude and longitude")
//                }
//
//            }
            
            print("here are my keys ")
            print("Key '\(String(describing: keys))' entered the search area and is at location '\(String(describing: location))'")
            if keys != Api.User.currentuserid{
                Api.User.getuserinfor(uid: keys) { (usr) in
                    if self.users.contains(usr){
                        return
                    }
                    print(usr.username)
                    print("here are the users name")
                    
                    if usr.isMale == nil{
                        return
                    }
                    
                    switch self.segment.selectedSegmentIndex{
                    case 0:
                    if usr.isMale!{
                        self.users.append(usr)
                    }
                    case 1:
                    if !usr.isMale!{
                        self.users.append(usr)
                    }
                    case 2:
                    self.users.append(usr)
                    default:
                        break
                    }
                    
                    
                                      
                    self.collectionview.reloadData()

                }
            }
            
//            self.myquerry.observe(.keyEntered, with: { (key: String!, location: CLLocation!) in
//                print("Key '\(String(describing: key))' entered the search area and is at location '\(String(describing: location))'")
//            })
})
        
    }
    
    
    func configuremanager(){
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        manager.pausesLocationUpdatesAutomatically = true
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            manager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedAlways) ||  (status == .authorizedWhenInUse) {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        ProgressHUD.showError("\(error.localizedDescription)")
        print(error.localizedDescription)
        print("it is error")
        manager.delegate = nil
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        manager.delegate = nil
        
        let updatedlocation: CLLocation = locations.first!
        let newcoordinate: CLLocationCoordinate2D = updatedlocation.coordinate
        
        print("im here ")
        let userdefaults: UserDefaults = UserDefaults.standard
        userdefaults.set("\(newcoordinate.latitude)", forKey: "latest_latitude")
        userdefaults.set("\(newcoordinate.longitude)", forKey: "latest_longitude")
        
        sendlocationtofirebase()

        
    }
    
    
    func sendlocationtofirebase(){

        if let userlatitde = UserDefaults.standard.value(forKey: "latest_latitude") as? String, let userlngitude = UserDefaults.standard.value(forKey: "latest_longitude") as? String{
            
            self.userlatitude = userlatitde
            self.userlongitude = userlngitude
            
            if !self.userlatitude.isEmpty && !self.userlongitude.isEmpty{
                let location: CLLocation = CLLocation(latitude: CLLocationDegrees(Double(self.userlatitude)!), longitude: CLLocationDegrees(Double(self.userlongitude)!))
                
                self.geofireref = S.ref.init().databasegeo
                self.geofire = GeoFire(firebaseRef: geofireref)
                self.geofire.setLocation(location, forKey: Api.User.currentuserid)
                S.ref.init().dbspecificuser(uid: Api.User.currentuserid).updateChildValues([LAT:userlatitde, LONG: userlngitude])
                self.geofire.setLocation(location, forKey: Api.User.currentuserid) { (error) in
                    if error != nil{
                        
                    }
                    print("sucessfully updated")
                }
                
                self.geofire.setLocation(location, forKey: Api.User.currentuserid) { (error) in
                    if error != nil{
                        print("error is here")
                    }
                    self.getuser()
                    
                }
                
                
            }
            
        }
        
        
    }
    
    @IBAction func segment_Changed(_ sender: Any) {
        getuser()
    }
    
    
    @IBAction func mapButton_Tapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mapVc = storyboard.instantiateViewController(identifier: "Mapviewcontroller") as!  MapViewController
        mapVc.user = self.users
        self.navigationController?.pushViewController(mapVc, animated: true)
    }
    
    
    @IBAction func cancel_Button(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    func setupNavigation(){
        
            
//  let refresh = UIBarButtonItem(image: UIImage(named: "icon-direction"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(refreshtapped))
        navigationItem.title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
//        myslider.frame = CGRect(x: 0, y: 0, width: 200, height: 20)
//        myslider.maximumValue = 999
//        myslider.minimumValue = 1
//        myslider.isContinuous = true
//        myslider.value = Float(distances)
//        myslider.tintColor = UIColor(red: 93/255, green: 79/255, blue: 141/255, alpha: 1)
//        myslider.addTarget(self, action: #selector(slidervaluechanged(slider: event:)), for: UIControl.Event.valueChanged)
    
//        navigationItem.rightBarButtonItems = [refresh]
        
//        navigationItem.titleView = myslider
            }
    
    
    @objc func refreshtapped(){
        self.getuser()
        
    }
    
//    @objc func  slidervaluechanged(slider: UISlider, event: UIEvent){
//        print(Double(slider.value))
//        if let touchevent = event.allTouches?.first{
//            distances = Double(slider.value)
//            switch touchevent.phase {
//            case .began:
//                print("began")
//            case .moved:
//                print("moved")
//            case .ended:
//                getuser()
//            default:
//                break
//            }
//
//        }
//
//    }

}
extension userAroundViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Collectionview", for: indexPath) as!  useraroundCollectionViewCell
        
        let user = users[indexPath.item]
        cell.controller = self
        
        cell.loaddata(user)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as?  useraroundCollectionViewCell{
            let storyboard  = UIStoryboard(name: "Main", bundle: nil)
                  let detailVc = storyboard.instantiateViewController(identifier: profileDetail) as Detail_ProfileViewController
            detailVc.detailuser = cell.user
                  self.navigationController?.pushViewController(detailVc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: view.frame.size.width/3 - 2, height: view.frame.size.width/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}

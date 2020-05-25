//
//  useraroundCollectionViewCell.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 15/03/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class useraroundCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avtar: UIImageView!
    
    @IBOutlet weak var agelabel: UILabel!
    
    @IBOutlet weak var distancelabel: UILabel!
    
    @IBOutlet weak var onlinestatus: UIImageView!
    
    var user: User!
    var onlinehandler: DatabaseHandle!
    var profilehandle: DatabaseHandle!
    var controller: userAroundViewController!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        onlinestatus.backgroundColor = UIColor.red
        onlinestatus.layer.borderWidth = 2
        onlinestatus.layer.borderColor = UIColor.white.cgColor
        onlinestatus.layer.cornerRadius = 10/2
        onlinestatus.clipsToBounds = true
        avtar.clipsToBounds = true
    }
    
    func loaddata(_ useer: User){
        self.user = useer
//        self.avtar.loadImage(useer.photourl)
     
        self.avtar.loadImage(useer.photourl) { (image) in
            useer.profileImage = image
        }
        if let age = useer.age{
            self.agelabel.text = "\(age)"
            
        }else{
            self.agelabel.text = ""
        }
        self.distancelabel.text = useer.username
//        guard let _ = _currentlocatn else{
//            return
//        }
        
//        if !user.latitude.isEmpty && !user.longitude.isEmpty{
//            let userlocation = CLLocation(latitude: Double(user.latitude)!, longitude: Double(user.longitude)!)
//            let distanceInKM: CLLocationDistance = userlocation.distance(from: _currentlocatn!) / 1000
//            distancelabel.text = String(format: "%.2f Km", distanceInKM)
//        }else{
//            distancelabel.text = ""
//        }
        
    }
    
}

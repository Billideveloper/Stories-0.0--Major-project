//
//  MapTableViewCell.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 29/03/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class MapTableViewCell: UITableViewCell {

    @IBOutlet weak var mapview: MKMapView!
    
    @IBOutlet weak var mapicon: UIImageView!
    
    var controller: Detail_ProfileViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mapicon.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(showMap))
        mapicon.addGestureRecognizer(tapgesture)
        
    }
    
    
    @objc func showMap(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mapvc = storyboard.instantiateViewController(identifier: "Mapviewcontroller") as! MapViewController
        mapvc.user = [controller!.detailuser]
        controller?.navigationController?.pushViewController(mapvc, animated: true)
        
        
    }
    
    
    func configure(location: CLLocation){
        let annoation = MKPointAnnotation()
        annoation.coordinate = location.coordinate
        self.mapview.addAnnotation(annoation)
        let region = MKCoordinateRegion(center: annoation.coordinate, latitudinalMeters: 11500, longitudinalMeters: 11500)
        self.mapview.setRegion(region, animated: true)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

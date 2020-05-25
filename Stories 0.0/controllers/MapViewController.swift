//
//  MapViewController.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 24/03/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit
import  MapKit
import CoreLocation
import Firebase

class MapViewController: UIViewController , MKMapViewDelegate{
    
    
    @IBOutlet weak var mapView: MKMapView!
    var user = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        addannotations()
        mapView.showsUserLocation = true
        // Do any additional setup after loading the view.
    }
    
    
    func addannotations(){
        
        var nearbyannotaion: [MKAnnotation]  = []
        for user in user{
            let location = CLLocation(latitude: Double(user.latitude)!, longitude: Double(user.longitude)!)
            let annotaions = Userannotations()
            annotaions.title = user.username
            if let age = user.age{
                annotaions.subtitle = "age: \(age)"
            }
            if let ismale = user.isMale{
                annotaions.isMale = (ismale == true)  ?  true : false
                
            }
            annotaions.coordinate = location.coordinate
            annotaions.profileImage = user.profileImage
            
            nearbyannotaion.append(annotaions)
            
        }
        self.mapView.showAnnotations(nearbyannotaion, animated: true)
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
               self.tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func back_button(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "myPin"
        var annotaionView: MKAnnotationView?
        
        if annotation.isKind(of: MKUserLocation.self){
            annotaionView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
            annotaionView?.image = UIImage(named: "icon-user")
        }else if let deqAno = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        {
            annotaionView = deqAno
            annotaionView?.annotation = annotation
            
        }else{
            let annoview = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annoview.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)
            annotaionView = annoview
            
        }
        
        if let anoview = annotaionView, let ano = annotation as? Userannotations{
            anoview.canShowCallout = true
            let image = ano.profileImage
            let resizeimage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            resizeimage.layer.cornerRadius = 25
            resizeimage.clipsToBounds = true
            resizeimage.contentMode = .scaleAspectFill
            resizeimage.image = image
            
            UIGraphicsBeginImageContextWithOptions(resizeimage.frame.size, false, 0.0)
            resizeimage.layer.render(in: UIGraphicsGetCurrentContext()!)
            
            let thumbnail =  UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            anoview.image = thumbnail
            
            let btn = UIButton()
            btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            btn.setImage(UIImage(named: "icon-direction"), for: UIControl.State.normal)
            annotaionView?.rightCalloutAccessoryView = btn
            
            
            let lefticon = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            if let ismale = ano.isMale{
                lefticon.image = (ismale == true) ? UIImage(named: "icon-male") : UIImage(named: "icon-female")
            }else{
                lefticon.image = UIImage(named: "icon-gender")
            }
            annotaionView?.leftCalloutAccessoryView = lefticon
            
        }
        return annotaionView
    }
    
    @IBAction func ZoomIn(_ sender: Any) {
        
        var  region = MKCoordinateRegion()
                region = self.mapView.region;
                region.span.latitudeDelta /= 2.0;
                region.span.longitudeDelta /= 2.0;
                self.mapView.setRegion(region, animated: true)
        
            }
    
    @IBAction func ZoomOut(_ sender: Any) {
        var  region = MKCoordinateRegion()
        region = self.mapView.region;
        region.span.latitudeDelta = min(region.span.latitudeDelta * 2.0, 180.0)
        region.span.longitudeDelta = min(region.span.longitudeDelta * 2.0, 180.0)
        
        self.mapView.setRegion(region, animated: true)

    }
    
    

}

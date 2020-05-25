//
//  Detail_ProfileViewController.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 28/03/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import ProgressHUD

class Detail_ProfileViewController: UIViewController {

    var detailuser: User!
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var avtarimageview: UIImageView!
    
    @IBOutlet weak var back_button: UIButton!
    
    @IBOutlet weak var gender_image: UIImageView!
    
    @IBOutlet weak var agelabel: UILabel!
    
    @IBOutlet weak var user_Name: UILabel!
    
    @IBOutlet weak var sendMessage: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        sendMessage.layer.cornerRadius = 5
        sendMessage.clipsToBounds = true
        
        self.avtarimageview.loadImage(detailuser.photourl)
        //avtarimageview.image = detailuser.profileImage
        let framegradient = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 350)
        avtarimageview.addblackgradientLayer(frame: framegradient, colors: [.clear, .black])
        user_Name.text = detailuser.username
      
        if detailuser.age != nil{
            agelabel.text = "\(detailuser.age!)"
        }else{
            agelabel.text = ""
        }
        
        if let isMale = detailuser.isMale{
            let gendername = (isMale == true)  ? "icon-male" :"icon-female"
            
            gender_image.image = UIImage(named: gendername)?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        }else{
            gender_image.image = UIImage(named: "icon-gender")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)

            
        }
        gender_image.tintColor =  .white
        tableview.contentInsetAdjustmentBehavior = .never

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false

    }

    

    @IBAction func back_button(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func sendMessage_clicked(_ sender: Any) {
        
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
                
        let chatvc = storyboard.instantiateViewController(identifier: S.chat.chatsceneid) as chatViewController
        chatvc.chatpartner = avtarimageview.image
        chatvc.partnerusername = user_Name.text
        chatvc.partneruserid = detailuser.uid
                                   
        print(chatvc.partneruserid as Any)
                  
        self.navigationController?.pushViewController(chatvc, animated: true)
        
    }
    
}
extension Detail_ProfileViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultcell", for: indexPath)
            cell.imageView?.image = UIImage(named: "show_email")
            cell.textLabel?.text = detailuser.email
            cell.selectionStyle = .none
            return cell
            
        case 1:
                let cell2 = tableView.dequeueReusableCell(withIdentifier: "defaultcell", for: indexPath)
                cell2.imageView?.image = UIImage(named: "map")
                cell2.selectionStyle = .none
                if !detailuser.latitude.isEmpty, !detailuser.longitude.isEmpty{
                    let mylocation = CLLocation(latitude: CLLocationDegrees(Double(detailuser.latitude)!), longitude: CLLocationDegrees(Double(detailuser.longitude)!))
                    let geocoder = CLGeocoder()
                    geocoder.reverseGeocodeLocation(mylocation) { (placemark, error) in
                        if error == nil , let placemarks = placemark, placemarks.count > 0{
                            if let placemrk = placemarks.last{
                                var text = ""
                                
                                if let throughfare = placemrk.thoroughfare{
                                    text = "\(throughfare)"
                                    cell2.textLabel?.text = text
                                    
                                }
                                
                                if let postalcode = placemrk.locality{
                                    text = text + ""   + postalcode
                                    cell2.textLabel?.text = text
                                }
                                
                                if let locality = placemrk.locality{
                                    text = text + ""  + locality
                                    cell2.textLabel?.text = text
                                }
                                
                                if let country = placemrk.country{
                                    text = text + ""  + country
                                    cell2.textLabel?.text = text
                                    cell2.textLabel?.adjustsFontSizeToFitWidth = true
                                    cell2.userInteractionEnabledWhileDragging = false
                                    cell2.selectionStyle = .none
                                }
                            }
                        }
                    }
                }
                return cell2
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "defaultcell", for: indexPath)
                cell.imageView?.image = UIImage(named: "status-show")
                cell.textLabel?.text =  detailuser.status
                cell.selectionStyle = .none
                return cell
            
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "Mapcell", for: indexPath) as! MapTableViewCell
                cell.controller = self
                   if !detailuser.latitude.isEmpty, !detailuser.longitude.isEmpty{
                                 let mylocation = CLLocation(latitude: CLLocationDegrees(Double(detailuser.latitude)!), longitude: CLLocationDegrees(Double(detailuser.longitude)!))
                    
                    cell.configure(location: mylocation)
                    
                    
                }
                cell.selectionStyle = .none
                


        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3{
            return 300
            
        }
        return 44
    }
    
}

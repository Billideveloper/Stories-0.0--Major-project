//
//  usersTableViewCell.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 18/02/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit
import  FirebaseAuth
import Firebase
import SDWebImage

class usersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userprofile: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var userstatus: UILabel!
    
    var userid: String!
    
    var user: User!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userprofile.layer.cornerRadius = 30
        userprofile.clipsToBounds = true
        userprofile.layer.borderWidth = 1
        userprofile.layer.borderColor = UIColor.black.cgColor
        
    }

    func loadData(_ user: User){
        
        
        self.user = user
        
        self.userid = user.uid
        
        self.userstatus.text = user.status
        
        self.username.text = user.username
        
        self.userprofile.loadImage(user.photourl)
                
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}

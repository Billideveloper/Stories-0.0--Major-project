//
//  Storiescell.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 20/01/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit

class Storiescell: UITableViewCell , UITextViewDelegate{
    
    
    @IBOutlet weak var userProfileImage: UIImageView!
    
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var storyCoverImage: UIImageView!
    
    @IBOutlet weak var storyTitle: UILabel!
    
    @IBOutlet weak var storysubTitle: UILabel!
    
    @IBOutlet weak var storyImage: UIImageView!
    
    @IBOutlet weak var story: UITextView!
    
    @IBOutlet weak var storyLikes: UILabel!
    
    @IBOutlet weak var storyFalgs: UILabel!
    
    @IBOutlet weak var storyHook: UILabel!
    
    
var textChanged: ((String) -> Void)?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        story.delegate = self
        
        userProfileImage.layer.cornerRadius = userProfileImage.frame.size.height / 2

        userProfileImage.layer.borderWidth = 1
        userProfileImage.layer.borderColor = UIColor.black.cgColor
      
        // Initialization code
    }
    
    func textChanged(action: @escaping (String) -> Void) {
        self.textChanged = action
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
    
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


//
//  MessageTableViewCell.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 10/03/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileimage: UIImageView!
    
    
    @IBOutlet weak var bubbleview: UIView!
    
    @IBOutlet weak var textmessagelabel: UILabel!
    
    @IBOutlet weak var playbutton: UIButton!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var photomessage: UIImageView!
    
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    
    @IBOutlet weak var bubblerightconstraint: NSLayoutConstraint!
    @IBOutlet weak var bubbleleftconstraint: NSLayoutConstraint!
    @IBOutlet weak var widthconstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bubbleview.layer.cornerRadius = 15
        bubbleview.clipsToBounds = true
        bubbleview.layer.borderWidth = 0.4
        textmessagelabel.numberOfLines = 0
        photomessage.layer.cornerRadius = 15
        photomessage.clipsToBounds = true
        profileimage.layer.cornerRadius = 16
        profileimage.clipsToBounds = true
        
        photomessage.isHidden = true
        profileimage.isHidden = true
        textmessagelabel.isHidden = true
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photomessage.isHidden = false
               profileimage.isHidden = false
               textmessagelabel.isHidden = false
    }
    
    func configurecell(uid: String, message: Message, image: UIImage){
        let text = message.text
        if !text.isEmpty{
            textmessagelabel.isHidden = false
            textmessagelabel.text = message.text
            
            let widthvalue = text.estimateframefortext(text).width + 50
            
            if widthvalue < 75 {
                widthconstraint.constant = 100
                
            }else{
                widthconstraint.constant = widthvalue
                
            }
            datelabel.textColor = .lightGray
        }else{
        
            photomessage.isHidden = false
            photomessage.loadImage(message.imageurl)
            bubbleview.layer.borderColor = UIColor.clear.cgColor
            widthconstraint.constant = 250
            datelabel.textColor = .white
            
        }
        
        if uid == message.from{
            profileimage.isHidden = true
            bubbleview.backgroundColor = UIColor.green
        
            bubbleview.layer.borderColor = UIColor.clear.cgColor
            bubblerightconstraint.constant = 8
            bubbleleftconstraint.constant = UIScreen.main.bounds.width - widthconstraint.constant -  bubblerightconstraint.constant
        }else{
            profileimage.isHidden = false
            bubbleview.backgroundColor = UIColor.white
            profileimage.image = image
            bubbleview.layer.borderColor = UIColor.lightGray.cgColor
            bubbleleftconstraint.constant = 55
            
            bubblerightconstraint.constant = UIScreen.main.bounds.width - widthconstraint.constant -
            bubbleleftconstraint.constant
        }
        
        let date = Date(timeIntervalSince1970: message.date)
        print(date)
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension String{
    func estimateframefortext(_ text: String)  -> CGRect{
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key .font : UIFont.systemFont(ofSize: 16)],  context: nil)
        
    }
}

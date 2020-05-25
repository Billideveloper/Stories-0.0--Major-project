//
//  profileCell.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 26/01/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit

class profileCell: UITableViewCell {
    
    @IBOutlet weak var profilecelltitle: UILabel!
    
    @IBOutlet weak var profilecellsubtitle: UILabel!
    
    @IBOutlet weak var profilecellhook: UILabel!
    @IBOutlet weak var profilecellimageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

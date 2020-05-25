//
//  profileTableViewCell.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 26/01/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit

class profileTableViewCell: UITableViewCell {
    

    @IBOutlet weak var pimage: UIImageView!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

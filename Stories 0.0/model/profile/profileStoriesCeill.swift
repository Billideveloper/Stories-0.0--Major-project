//
//  profileStoriesCeill.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 26/01/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit

class profileStoriesCeill: UITableViewCell {
    
    
    @IBOutlet weak var pstoryTitle: UILabel!
    @IBOutlet weak var pstorySubtitle: UILabel!
    
    @IBOutlet weak var pstoryimage: UIImageView!
    @IBOutlet weak var pstoryhook: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

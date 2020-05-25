//
//  exteionuserprofile.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 21/02/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView{
    
    func loadImage(_ urlString: String?, onSucess: ((UIImage)  -> Void)? = nil){
        self.image = UIImage()
        guard let string = urlString else{
            return
        }
        guard let url = URL(string: string) else {return}
        self.sd_setImage(with: url) { (image, error, type, url) in
            if onSucess != nil, error == nil{
                onSucess!(image! )
                
            }
        }
    }
}

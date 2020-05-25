//
//  extension.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 28/03/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    func addblackgradientLayer(frame: CGRect, colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.locations = [0.5, 1.0]
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
        
    }
}

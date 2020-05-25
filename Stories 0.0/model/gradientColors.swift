//
//  sucessController.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 16/01/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    func gradientcolor(colorOne: UIColor, colorTwo: UIColor){
        
        let gradientlayer = CAGradientLayer()
        gradientlayer.frame = bounds
        gradientlayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientlayer.locations = [0.0, 1.0]
        gradientlayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        layer.insertSublayer(gradientlayer, at: 0)
        
    }
}

//
//  UIColor+Extensions.swift
//  exmachina
//
//  Created by M'haimdat omar on 31-05-2019.
//  Copyright © 2019 M'haimdat omar. All rights reserved.
//

import UIKit

public extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static var customBackgroundColor: UIColor = {
        return UIColor(r: 255, g: 255, b: 255)
    }()

    static var uploadBtnColor = UIColor(r: 171, g: 224, b: 135)
    static var openCameraBtnColor = UIColor(r: 57, g: 125, b: 84)
    static var shadowColor = UIColor(r: 0, g: 0, b: 0)
    
}



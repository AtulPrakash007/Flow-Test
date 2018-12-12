//
//  UIColorExtension.swift
//  Flow-Test
//
//  Created by WorkStation on 12/11/18.
//  Copyright © 2018 Atul Prakash. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
/**
 * Convert color from Hex value
**/
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

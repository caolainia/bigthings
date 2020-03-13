//
//  UIColor+Extension.swift
//  BigThings
//
//  Created by PP on 2019/11/8.
//  Copyright © 2019 PP. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    /// Init from UInt64 e.g. 0x333333
    ///
    /// - Parameters:
    ///   - hex: UInt64
    ///   - alpha: alpha
    convenience init(hex: UInt64, alpha: CGFloat = 1) {
        let components = (
            R: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            G: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            B: CGFloat(hex & 0x0000FF) / 255.0
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }
}

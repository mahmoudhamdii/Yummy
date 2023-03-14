//
//  UIButton+Extensions.swift
//  Yummy
//
//  Created by hamdi on 13/03/2023.
//

import Foundation
import UIKit
extension UIButton {
    @IBInspectable var btnCornerRadius :CGFloat {
        get{
            return self.btnCornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
}


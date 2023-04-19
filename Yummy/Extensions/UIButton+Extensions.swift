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
    
        var addBorder: Void {
            layer.borderWidth = 1
            layer.borderColor = #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1).cgColor
        }
    }



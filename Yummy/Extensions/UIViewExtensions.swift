//
//  UIViewExtensions.swift
//  Yummy
//
//  Created by hamdi on 23/02/2023.
//

import Foundation
import UIKit
extension UIView {
  @IBInspectable var cornerRadius :CGFloat {
        get{
            return self.cornerRadius
            
        }
        set{
            self.layer.cornerRadius = newValue
            
        }
    }
    static func setBorder(view:UIView){
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.darkGray.cgColor
    }
}

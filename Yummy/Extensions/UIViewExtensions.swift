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
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
       
    }
    static func fadeInViews(views: [UIView], duration: TimeInterval = 0.5, delay: TimeInterval = 0.0) {
        for view in views {
            view.alpha = 0.0
            UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseInOut], animations: {
                view.alpha = 1.0
            }, completion: nil)
        }
    }
    
}

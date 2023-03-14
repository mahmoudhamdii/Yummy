//
//  UIViewController+Extenction.swift
//  Yummy
//
//  Created by hamdi on 25/02/2023.
//

import Foundation
import UIKit
extension UIViewController {
    static var identfier :String {
        return String(describing: self)
    }
    static func instantiate (storyBord :String) -> Self {
        let storyboard = UIStoryboard(name:storyBord, bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: identfier) as! Self
       
    }
}

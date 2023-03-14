//
//  Utalities.swift
//  Yummy
//
//  Created by hamdi on 08/03/2023.
//

import Foundation
import UIKit 
class Utalities {
    static func addTXFImage(textField:UITextField ,img :UIImage){
        let rightImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height))
        rightImageView.image = img
        textField.rightView = rightImageView
        textField.rightViewMode = .always
        
    }
    static func isPasswordValid(_ password : String) -> Bool {
        
//       let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
       let passwordTest = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
        return passwordTest.evaluate(with: password)
    }
}

//
//  TextFieldValdiator+Exensions.swift
//  Yummy
//
//  Created by hamdi on 09/03/2023.
//

import Foundation
import UIKit
extension UITextField {
    var trimmedText: String? {
        get {
            return text?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        set {
            text = newValue
        }
    }
  static  func addTXFImage(textField:UITextField ,img :UIImage){
        let image = img
        let imageView = UIImageView(image: image)
        imageView.tintColor = #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)
        textField.rightViewMode = .always
        textField.rightView = imageView
      
        let imageSize = imageView.frame.size
        let rightViewFrame = CGRect(x: textField.frame.size.width  - imageSize.width - 10.0, y: (textField.frame.size.height - imageSize.height) / 2.0, width: imageSize.width, height: imageSize.height)
        imageView.frame = rightViewFrame
        textField.layer.borderColor =  #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1).cgColor
        textField.layer.borderWidth = 2.0
       
    }
}
class Utalities {
   
    static func isPasswordValid(_ password : String) -> Bool {
        
//       let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
       let passwordTest = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
        return passwordTest.evaluate(with: password)
    }
}




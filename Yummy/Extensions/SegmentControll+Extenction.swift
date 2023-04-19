//
//  SegmentControll+Extenction.swift
//  Yummy
//
//  Created by hamdi on 19/04/2023.
//

import Foundation
import UIKit
extension UISegmentedControl {
    
    func setup() {
        var titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        setTitleTextAttributes(titleTextAttributes, for: .normal)
        setTitleTextAttributes(titleTextAttributes, for: .selected)
        
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)]
        setTitleTextAttributes(titleTextAttributes, for: .normal)
    }
    
    var selectedSegmentTitle: String? {
        return titleForSegment(at: selectedSegmentIndex)
    }
    
}


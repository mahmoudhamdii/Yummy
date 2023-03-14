//
//  String+Extensions.swift
//  Yummy
//
//  Created by hamdi on 24/02/2023.
//

import Foundation
extension String {
    var asUrl :URL? {
        return URL(string: self)
    }
}

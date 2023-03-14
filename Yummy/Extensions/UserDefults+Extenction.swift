//
//  UserDefults+Extenction.swift
//  Yummy
//
//  Created by hamdi on 28/02/2023.
//

import Foundation
extension UserDefaults {
    private enum UserDefultsKeys :String {
        case hasOnboarded
    }
    var hasOnboarded :Bool {
        get{
            bool(forKey: UserDefultsKeys.hasOnboarded.rawValue)
        }
        set {
            setValue(newValue, forKey: UserDefultsKeys.hasOnboarded.rawValue)
        }
    }
}

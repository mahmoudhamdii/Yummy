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
        case hasAuthorization
        case hasEnableDarkMode
    }
    var hasOnboarded :Bool {
        get{
            bool(forKey: UserDefultsKeys.hasOnboarded.rawValue)
        }
        set {
            setValue(newValue, forKey: UserDefultsKeys.hasOnboarded.rawValue)
        }
    }
    var hasAuthorization :Bool {
        get{
            bool(forKey: UserDefultsKeys.hasAuthorization.rawValue)
        }
        set{
            setValue(newValue, forKey: UserDefultsKeys.hasAuthorization.rawValue)
        }
    }
    var hasEnableDarkMode :Bool {
        get{
            bool(forKey: UserDefultsKeys.hasEnableDarkMode.rawValue)
        }
        set{
            setValue(newValue, forKey: UserDefultsKeys.hasEnableDarkMode.rawValue)
        }
    }
}

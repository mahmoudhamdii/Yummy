//
//  Dish.swift
//  Yummy
//
//  Created by hamdi on 24/02/2023.
//

import UIKit
struct Dish :Decodable {
    let id, name, description, image: String?
        let calories: Int?
    var formatedCaleorie :  String {
        return "\(calories ?? 0 ) EGP"
    }
    
}

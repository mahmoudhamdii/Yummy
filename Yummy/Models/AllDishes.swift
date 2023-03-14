//
//  AllDishes.swift
//  Yummy
//
//  Created by hamdi on 27/02/2023.
//

import Foundation
struct AllDishes :Decodable {
    let categories: [DishCategory]?
        let populars: [Dish]?
        let specials: [Dish]?
    }


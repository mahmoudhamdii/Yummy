//
//  Route.swift
//  Yummy
//
//  Created by hamdi on 26/02/2023.
//

import Foundation
enum Route {
    static let baseUrl = "https://yummie.glitch.me/"
    case fetchAllCategories
    case placeOrder(String)
    case fetchCategoryDishes(String)
    case fetchfOrders
    var description :String {
        switch self {
            
        case .fetchAllCategories:
            return "/dish-categories"
        case .placeOrder(let dishID):
            return "/orders/\(dishID)"
        case .fetchCategoryDishes(let categortID):
            return "/dishes/\(categortID)"
        case .fetchfOrders :
            return "/orders"
        }
    }
    
}

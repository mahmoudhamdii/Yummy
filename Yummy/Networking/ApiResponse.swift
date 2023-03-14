//
//  ApiResponse.swift
//  Yummy
//
//  Created by hamdi on 27/02/2023.
//

import Foundation
struct ApiResponse<T:Decodable> :Decodable {
    // decode
    let status :Int // status code
    let massage :String?
    let data :T?
    let error :String?
    
}

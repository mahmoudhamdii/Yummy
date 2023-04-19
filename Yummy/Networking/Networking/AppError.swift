//
//  AppError.swift
//  Yummy
//
//  Created by hamdi on 27/02/2023.
//

import Foundation
enum AppError :LocalizedError {
    case errorDecoding
    case unKnownError
    case invalidUrl
    case serverError (String)
    var errorDescription: String? {
        switch self {
        
        case .errorDecoding:
            return "Response could not be decoded"
        case .unKnownError:
          return  "w!!!! I have no idea what go on "
        case .invalidUrl:
             return "Give me valid URl"
        case .serverError(let error):
            return error
        }
    }
    
}

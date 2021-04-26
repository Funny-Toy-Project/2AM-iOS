//
//  User.swift
//  2AM
//
//  Created by 전판근 on 2021/04/27.
//

import Foundation

struct LoginUser: Codable {
    let name: String
}

enum LoginError: Error {
    case defaulltError
    case error(code: Int)
    
    var msg: String {
        switch self {
        case .defaulltError:
            return "ERROR"
            
        case .error(let code):
            return "\(code) Error"
        }
    }
}

//
//  SignUpUser.swift
//  2AM
//
//  Created by 전판근 on 2021/04/27.
//

import Foundation

struct SignUpUser: Codable {
    let id: String
    let phone: String
}

enum SignUpError: Error {
    case defaultError
    case error(code: Int)
    
    var msg: String {
        switch self {
        case .defaultError:
            return "ERROR"
            
        case .error(let code):
            return "\(code) Error"
        }
    }
}

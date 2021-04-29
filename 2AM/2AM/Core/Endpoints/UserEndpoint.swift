//
//  UserEndpoint.swift
//  2AM
//
//  Created by 전판근 on 2021/04/28.
//

import Foundation

/// 유저 엔드포인트
enum UserEndpoint {
    
    /// 로그인
    case signin
    
    /// 가입
    case signup
}

extension UserEndpoint {
    
    /// 유저 엔드포인트 URL
    var urlString: String {
        switch self {
        case .signin:
            return "\(baseURL)/api/login"
            
        case .signup:
            return "\(baseURL)/api/sign-up"
        }
    }
}

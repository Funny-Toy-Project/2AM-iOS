//
//  APIError.swift
//  2AM
//
//  Created by 전판근 on 2021/04/27.
//

import Foundation

enum APIError: Error {
    
    // 디코딩 에러
    case decodingError
    
    // HTTP 통신 에러
    case httpError(Int)
    
    // 알 수 없는 에러
    case unknown
}

//
//  NetworkResult.swift
//  2AM
//
//  Created by 전판근 on 2021/04/27.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}

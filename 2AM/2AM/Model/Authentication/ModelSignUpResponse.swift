//
//  ModelSignUpResponse.swift
//  2AM
//
//  Created by 전판근 on 2021/04/26.
//

import Foundation

struct ModelSignUpResponse: Decodable {
    let code: Int
    let data: String?
    let msg: String
    let success: Bool
}

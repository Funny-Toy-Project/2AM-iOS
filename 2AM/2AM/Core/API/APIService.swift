//
//  APIService.swift
//  2AM
//
//  Created by 전판근 on 2021/04/27.
//

import Foundation
import RxSwift

protocol APIService {
    func request<T: Decodable>(with request: URLRequest) -> Observable<T>
    
}

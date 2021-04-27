//
//  APISession.swift
//  2AM
//
//  Created by 전판근 on 2021/04/27.
//

import Foundation
import RxSwift
import RxCocoa

struct APISession: APIService {
    
    /// 실질적으로 리퀘스트하는 메소드
    /// - Parameter request: URLRequest(메소드, 바디 등을 포함)
    /// - Returns: Observable<T: Decodable>
    func request<T>(with request: URLRequest) -> Observable<T> where T : Decodable {
        
        let maxAttempts = 4
        
        return Observable.create { observer in
            
            URLSession.shared.rx.response(request: request)
                .retry(when: { errors in
                    
                    return errors.enumerated().flatMap { attempt, error -> Observable<Int> in
                        
                        if attempt >= maxAttempts - 1 {
                            
                            return Observable.error(APIError.unknown)
                            
                        }
                        
                        return Observable<Int>.timer(
                            .seconds(attempt + 1),
                            scheduler: MainScheduler.instance
                        )
                        .take(1)
                        
                    }
                    
                })
                .subscribe(
                    onNext: { response in
                        
                        let statusCode = response.response.statusCode
                        
                        if (200..<300).contains(statusCode) {
                            // 정상 리퀘스트
                            
                            let data = response.data
                            let decoder = JSONDecoder()
                            
                            guard let decodedData = try? decoder.decode(T.self, from: data) else {
                                // Decoding 에러
                                
                                return observer.onError(APIError.decodingError)
                            }
                            
                            return observer.onNext(decodedData)
                            
                        } else {
                            // 비정상 리퀘스트
                            
                            #if DEBUG
                            
                            print(String(data: response.data, encoding: .utf8) as Any)
                            
                            #endif
                            
                            return observer
                                .onError(APIError.httpError(statusCode))
                            
                        }
                        
                    }, onError: { error in
                        
                        observer.onError(error)
                        
                    }
                )
            
        }
        
    }
    
}

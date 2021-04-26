//
//  SignUpModel.swift
//  2AM
//
//  Created by 전판근 on 2021/04/27.
//

import Foundation
import RxSwift
import RxCocoa

struct SignUpModel {
    func requestSignUp(id: String, pw: String, pwCheck: String, phone:String) -> Observable<Result<SignUpUser, SignUpError>> {
        
        return Observable.create { (observer) -> Disposable in
            if (id != "" && pw != "" && pwCheck != "" && phone != "") && (pw == pwCheck) {
                observer.onNext(.success(SignUpUser(id: id, phone: phone)))
            } else {
                observer.onNext(.failure(.defaultError))
            }
            
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}

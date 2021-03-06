//
//  LoginModel.swift
//  2AM
//
//  Created by 전판근 on 2021/04/27.
//

//import Foundation
//import RxSwift
//import RxCocoa
//
//struct LoginModel {
//    func requestLogin(id: String, pw: String) -> Observable<Result<LoginUser, LoginError>> {
//        return Observable.create { (observer) -> Disposable in
//            if id != "" && pw != "" {
//                observer.onNext(.success(LoginUser(user: id, password: pw)))
//            } else {
//                observer.onNext(.failure(.defaulltError))
//            }
//
//            observer.onCompleted()
//
//            return Disposables.create()
//        }
//    }
//}

import Foundation

struct Login {
    let email: String
    let password: String
}

//
//  LoginViewModel.swift
//  2AM
//
//  Created by 전판근 on 2021/04/27.
//

//import Foundation
//import RxSwift
//import RxCocoa
//
//struct LoginViewModel {
//    let idTfChanged = PublishRelay<String>()
//    let pwTfChanged = PublishRelay<String>()
//    let loginBtnTouched = PublishRelay<Void>()
//
//    let result: Signal<Result<LoginUser, LoginError>>
//
//    init(model: LoginModel = LoginModel()) {
//        result = loginBtnTouched
//            .withLatestFrom(Observable.combineLatest(idTfChanged, pwTfChanged))
//            .flatMapLatest { model.requestLogin(id: $0.0, pw: $0.1)}
//            .asSignal(onErrorJustReturn: .failure(.defaulltError))
//    }
//}

import RxSwift
import RxCocoa

class LoginViewModel {
    let emailObserver = BehaviorRelay<String>(value: "")
    let passObserver = BehaviorRelay<String>(value: "")
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(emailObserver, passObserver)
            .map { email, password in
                print("Email: \(email), Passworld: \(password)")
                return !email.isEmpty && password.count > 0
            }
    }
}

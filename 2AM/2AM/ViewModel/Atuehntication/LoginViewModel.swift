//
//  LoginViewModel.swift
//  2AM
//
//  Created by 전판근 on 2021/04/27.
//

import Foundation
import RxSwift
import RxCocoa

struct LoginViewModel {
    let idTfChanged = PublishRelay<String>()
    let pwTfChanged = PublishRelay<String>()
    let loginBtnTouched = PublishRelay<String>()
    
    let result: Signal<Result<User, LoginError>>
    
    init(model: LoginModel = LoginModel()) {
        result = loginBtnTouched
            .withLatestFrom(Observable.combineLatest(idTfChanged, pwTfChanged))
            .flatMapLatest { model.requestLogin(id: $0.0, pw: $0.1)}
            .asSignal(onErrorJustReturn: .failure(.defaulltError))
    }
}

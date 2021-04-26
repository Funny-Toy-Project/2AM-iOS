//
//  SignUpViewModel.swift
//  2AM
//
//  Created by 전판근 on 2021/04/27.
//

import Foundation
import RxSwift
import RxCocoa

struct SignUpViewModel {
    let idTfChanged = PublishRelay<String>()
    let pwTfChanged = PublishRelay<String>()
    let pwcTfChanged = PublishRelay<String>()
    let phoneTfChanged = PublishRelay<String>()
    let signUpBtnTouched = PublishRelay<Void>()
    
    let result: Signal<Result<SignUpUser, SignUpError>>
    
    init(model: SignUpModel = SignUpModel()) {
        result = signUpBtnTouched
            .withLatestFrom(Observable.combineLatest(idTfChanged, pwTfChanged, pwcTfChanged, phoneTfChanged))
            .flatMapLatest { model.requestSignUp(id: $0.0, pw: $0.1, pwCheck: $0.2, phone: $0.3)}
            .asSignal(onErrorJustReturn: .failure(.defaultError))
    }
}

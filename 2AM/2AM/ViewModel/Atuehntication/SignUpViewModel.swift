//
//  SignUpViewModel.swift
//  2AM
//
//  Created by 전판근 on 2021/04/26.
//

import RxSwift
import RxCocoa

protocol SignUpViewBindable {
    var id: BehaviorRelay<String?> { get }
    var password: BehaviorRelay<String?> { get }
    var nextBtnPressed: PublishRelay<Void> { get }
}


final class SignUpViewModel: SignUpViewBindable {
    
    private let bag = DisposeBag()
    
    var id = BehaviorRelay<String?>(value: nil)
    var password = BehaviorRelay<String?>(value: "")
    var nextBtnPressed = PublishRelay<Void>()
    
    let response = PublishSubject<(id: String?, password: String?)?>()
    
    init() {
        nextBtnPressed
            .subscribe(onNext: { [weak self] in
                self?.response.onNext((id: self?.id.value,
                                       password: self?.password.value))
            })
            .disposed(by: bag)
    }
    
    
}

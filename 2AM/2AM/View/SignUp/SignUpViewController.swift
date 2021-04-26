//
//  SignUpViewController.swift
//  2AM
//
//  Created by 전판근 on 2021/04/26.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
    
    //MARK:- Private
    
    private let bag = DisposeBag()
    private let viewModel = SignUpViewModel()
    
    private let labelTitle: UILabel = {
        let lb = UILabel()
        lb.text = "회원 가입"
        lb.textColor = .black
        lb.font = UIFont.boldSystemFont(ofSize: 30)
        return lb
    }()
    
    private let labelID = LabelLogin(title: "아이디")
    private let tfID = TextFieldLogin(title: "ID")
    private let labelPW = LabelLogin(title: "비밀번호")
    private let tfPassword = TextFieldLogin(title: "비밀번호")
    private let tfPasswordCheck = TextFieldLogin(title: "비밀번호 확인")
    
    private let buttonSignUp: UIButton = {
        let btn = UIButton()
        btn.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        btn.setTitle("회원가입", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        btn.backgroundColor = .systemBlue
        
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    private let labelPhone = LabelLogin(title: "전화번호")
    private let tfPhone = TextFieldLogin(title: "전화번호")
    
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        configureView()
        configureSubView()
        bindRx()
    }
}

//MARK:- Configure View
extension SignUpViewController {
    
    func configureView() {
        print("SIGN UP")
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        
        view.addSubview(labelTitle)
        view.addSubview(labelID)
        view.addSubview(tfID)
        
        view.addSubview(labelPW)
        view.addSubview(tfPassword)
        view.addSubview(tfPasswordCheck)
        view.addSubview(buttonSignUp)
        view.addSubview(labelPhone)
        view.addSubview(tfPhone)
    }
    
    func configureSubView() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        labelTitle.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(safeArea.snp.top).offset(50)
        }
        
        labelID.snp.makeConstraints {
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
            $0.top.equalTo(safeArea.snp.top).offset(150)
        }
        
        tfID.snp.makeConstraints {
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
            $0.top.equalTo(labelID.snp.bottom).offset(16)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-16)
        }
        
        labelPW.snp.makeConstraints {
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
            $0.top.equalTo(tfID.snp.bottom).offset(30)
        }
        
        tfPassword.snp.makeConstraints {
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
            $0.top.equalTo(labelPW.snp.bottom).offset(16)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-16)
        }
        
        tfPasswordCheck.snp.makeConstraints {
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
            $0.top.equalTo(tfPassword.snp.bottom).offset(16)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-16)
        }
        
        labelPhone.snp.makeConstraints {
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
            $0.top.equalTo(tfPasswordCheck.snp.bottom).offset(30)
        }
        
        tfPhone.snp.makeConstraints {
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
            $0.top.equalTo(labelPhone.snp.bottom).offset(16)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-16)
        }
        
        buttonSignUp.snp.makeConstraints {
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-16)
            $0.bottom.equalTo(safeArea.snp.bottom).offset(-30)
        }
    }
    
    func bindRx() {
        
        tfID.rx
            .text
            .orEmpty
            .bind(to: viewModel.idTfChanged)
            .disposed(by: bag)
        
        tfPassword.rx
            .text
            .orEmpty
            .bind(to: viewModel.pwTfChanged)
            .disposed(by: bag)
        
        tfPasswordCheck.rx
            .text
            .orEmpty
            .bind(to: viewModel.pwcTfChanged)
            .disposed(by: bag)
        
        
        tfPhone.rx
            .text
            .orEmpty
            .bind(to: viewModel.pwTfChanged)
            .disposed(by: bag)
        
        buttonSignUp.rx
            .tap
            .bind(to: viewModel.signUpBtnTouched)
            .disposed(by: bag)
        
        viewModel.result.emit(onNext: { (result) in
            switch result {
            case .success(let user):
                print(user)
                self.signUp2Login()
            case .failure(let err):
                print(err)
                self.showError()
            }
        })
        .disposed(by: bag)
    }
    
    func signUp2Login() {
        self.navigationController?.popViewController(animated: true)
        print("SUCCESS SIGN UP")
    }
    
    func showError() {
        print("SIGN UP ERROR")
    }
}

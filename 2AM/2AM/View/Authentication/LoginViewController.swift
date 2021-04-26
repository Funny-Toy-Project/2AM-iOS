//
//  LoginViewController.swift
//  2AM
//
//  Created by 전판근 on 2021/04/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    //MARK:- private
    
    private let bag = DisposeBag()
    
    private let labelTitle: UILabel = {
        let lb = UILabel()
        lb.text = "감성 글귀"
        lb.textColor = .black
        lb.font = UIFont.boldSystemFont(ofSize: 30)
        return lb
    }()
    
    
    private let labelLogin = LabelLogin(title: "로그인")
    private let tfLogin = TextFieldLogin(title: "로그인")
    
    private let labelPassword = LabelLogin(title: "비밀번호")
    private let tfPassword = TextFieldLogin(title: "비밀번호")
    
    private let buttonSignUp: UIButton = {
        let btn = UIButton()
        btn.setTitle("회원가입", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return btn
    }()
    
    private let buttonEditUser: UIButton = {
        let btn = UIButton()
        btn.setTitle("비밀번호 수정", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return btn
    }()
    
    private let labelBar: UILabel = {
        let lb = UILabel()
        lb.text = "|"
        lb.textColor = .systemBlue
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        return lb
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8.0
        stack.alignment = .center
        stack.distribution = .fillProportionally
        
        return stack
    }()
    
    private let buttonLogin: UIButton = {
        let btn = UIButton()
        btn.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        btn.setTitle("로그인", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        btn.backgroundColor = .systemBlue
        
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        
        configureView()
        configureSubView()
        bindRx()
    }
    
    private func push2SignUp() {
        let tabVC = TabBarController()
        navigationController?.pushViewController(tabVC, animated: true)
    }
    
    //MARK:- Configure
    func configureView() {
        view.backgroundColor = .white
        
        view.addSubview(labelTitle)
        view.addSubview(labelLogin)
        view.addSubview(tfLogin)
        view.addSubview(labelPassword)
        view.addSubview(tfPassword)
        view.addSubview(stackView)
        view.addSubview(buttonLogin)
    }
    
    func configureSubView() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        labelTitle.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(safeArea.snp.top).offset(50)
        }
        
        labelLogin.snp.makeConstraints {
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
            $0.top.equalTo(safeArea.snp.top).offset(200)
        }
        
        tfLogin.snp.makeConstraints {
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
            $0.top.equalTo(labelLogin.snp.bottom).offset(16)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-16)
        }
        
        labelPassword.snp.makeConstraints {
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
            $0.top.equalTo(tfLogin.snp.bottom).offset(30)
        }
        
        tfPassword.snp.makeConstraints {
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
            $0.top.equalTo(labelPassword.snp.bottom).offset(16)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-16)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(tfPassword.snp.bottom).offset(16)
            $0.centerX.equalTo(safeArea.snp.centerX)
        }
        
        for btn in [buttonEditUser, labelBar, buttonSignUp] {
                    stackView.addArrangedSubview(btn)
                }
        
        buttonLogin.snp.makeConstraints {
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-16)
            $0.bottom.equalTo(safeArea.snp.bottom).offset(-30)
        }
    }
    
    func bindRx() {
        buttonEditUser.rx
            .tap
            .bind {
                print("비밀번호 수정")
            }
            .disposed(by: bag)
        
        buttonSignUp.rx
            .tap
            .bind {
                print("회원가입")
            }
            .disposed(by: bag)
        
        buttonLogin.rx
            .tap
            .bind { [weak self] in
                self?.push2SignUp()
                print("로그인")
            }
            .disposed(by: bag)
    }
}

//
//  LoginViewController.swift
//  2AM
//
//  Created by 전판근 on 2021/04/25.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    //MARK:- private
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
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        
        configureView()
        configureSubView()
    }
    
    //MARK:- Configure
    func configureView() {
        view.backgroundColor = .white
        
        view.addSubview(labelTitle)
        view.addSubview(labelLogin)
        view.addSubview(tfLogin)
        view.addSubview(labelPassword)
        view.addSubview(tfPassword)
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
    }
}

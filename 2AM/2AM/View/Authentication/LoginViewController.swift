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
    
//    private let labelLogin: UILabel = {
//        let lb = UILabel()
//        lb.text = "로그인"
//        lb.font = UIFont.boldSystemFont(ofSize: 24)
//
//        return lb
//    }()
    private let labelLogin = LabelLogin(title: "로그인")
    
    private let tfLogin: UITextField = {
        let tf = UITextField()
        tf.placeholder = "로그인"
        tf.addLeftPadding()
        
        tf.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0, alpha: 1).cgColor
        
        return tf
    }()
    
    private let labelPassword = LabelLogin(title: "비밀번호")
    
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
    }
}


extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}

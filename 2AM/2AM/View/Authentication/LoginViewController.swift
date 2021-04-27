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
import Alamofire

class LoginViewController: UIViewController {
    
    //MARK:- private
    
    private let bag = DisposeBag()
    private let viewModel = LoginViewModel()
    
    let userEmail = "qqqq"
    let userPassword = "1q2w3e4r"
    
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
        let signupVC = SignUpViewController()
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    private func push2Login() {
        let tabVC = TabBarController()
        navigationController?.pushViewController(tabVC, animated: true)
    }
    
    private func showError() {
        print("LOGIN ERROR")
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
        
        tfLogin.rx
            .text
            .orEmpty
            .bind(to: viewModel.emailObserver)
            .disposed(by: bag)
        
        tfPassword.rx
            .text
            .orEmpty
            .bind(to: viewModel.passObserver)
            .disposed(by: bag)
        
        buttonEditUser.rx
            .tap
            .bind {
                print("비밀번호 수정")
            }
            .disposed(by: bag)
        
        buttonSignUp.rx
            .tap
            .bind { [weak self] in
                self?.push2SignUp()
                print("회원가입")
            }
            .disposed(by: bag)
        
        
        viewModel.isValid.bind(to: buttonLogin.rx.isEnabled)
            .disposed(by: bag)
        
        viewModel.isValid
            .map { $0 ? 1 : 0.3 }
            .bind(to: buttonLogin.rx.alpha)
            .disposed(by: bag)
        
        buttonLogin.rx
            .tap
            .subscribe (
                onNext: {
                    [weak self] _ in
                    
                    guard let idText = self?.tfLogin.text,
                          let pwText = self?.tfPassword.text else {
                        return
                    }
                    
                    // 서버 통신 함수 호출 -> 결과는 networkResult로 변환됨
                    AuthService.shared.signIn(nickname: idText, password: pwText) { (networkResult) -> (Void) in
                        // 결과에 따라 알림창에 뜨는 메시지를 다르게 설정
                        switch networkResult {
                        case .success(let data):
                            if let signInData = data as? LoginData {
                                print("\(signInData)")
                                let alert = UIAlertController(title: "로그인 성공", message: "환영합니다", preferredStyle: .alert)
                                let ok = UIAlertAction(title: "확인", style: .default)  { (action) -> Void in
                                    self?.push2Login()
                                }
                                alert.addAction(ok)
                                self?.present(alert, animated: true, completion: nil)
                            }
                            
                        case .requestErr(let msg):
                            if let message = msg as? String {
                                let alert = UIAlertController(title: "로그인 실패", message: message, preferredStyle: .alert)
                                let ok = UIAlertAction(title: "확인", style: .default)
                                alert.addAction(ok)
                                self?.present(alert, animated: true, completion: nil)
                            }
                        case .pathErr:
                            print("pathErr")
                        case .serverErr:
                            print("serverErr")
                        case .networkFail:
                            print("networkFail")
                        }
                    }
                    
                    if self?.userEmail == self?.viewModel.emailObserver.value &&
                        self?.userPassword == self?.viewModel.passObserver.value {
                        let alert = UIAlertController(title: "로그인 성공", message: "환영합니다", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "확인", style: .default)  { (action) -> Void in
                            self?.push2Login()
                        }
                        alert.addAction(ok) 
                        self?.present(alert, animated: true, completion: nil)
                    
                    } else {
                        let alert = UIAlertController(title: "로그인 실패", message: "아이디 혹은 비밀번호를 다시 확인해주세요", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "확인", style: .default)
                        alert.addAction(ok)
                        self?.present(alert, animated: true, completion: nil)
                    }
                }).disposed(by: bag)

    }
}

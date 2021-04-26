//
//  TextFieldLogin.swift
//  2AM
//
//  Created by 전판근 on 2021/04/26.
//

import UIKit

class TextFieldLogin: UITextField {
    
    init(title: String) {
        super.init(frame: .zero)
        configureTextField(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError(">> TextField Login : init(coder:) has not been implemented")
    }
    
    private func configureTextField(title: String) {
        
        placeholder = "\(title)"
        snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        if title == "비밀번호" {
            isSecureTextEntry = true
        }
        
        addLeftPadding()
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0, alpha: 1).cgColor
    }
}

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}

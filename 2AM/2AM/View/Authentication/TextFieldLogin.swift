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
        autocapitalizationType = .none
        
        if (title == "비밀번호") || (title == "비밀번호 확인")  {
            isSecureTextEntry = true
            autocorrectionType = .no
        }
        
//        if title == "전화번호" {
//            keyboardType = .numberPad
//        }
        
        addLeftPadding()
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0, alpha: 1).cgColor
    }
}

extension UITextField: UITextFieldDelegate {
    
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}

extension String {
    
    func pretty() -> String {
        let _str = self.replacingOccurrences(of: "-", with: "") // 하이픈 모두 빼준다
        let arr = Array(_str)
        if arr.count > 3 {
            let prefix = String(format: "%@%@", String(arr[0]), String(arr[1]))
            if prefix == "02" { // 서울지역은 02번호
                if let regex = try? NSRegularExpression(pattern: "([0-9]{2})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2-$3")
                    return modString
                    
                }
                
            } else if prefix == "15" || prefix == "16" || prefix == "18" { // 썩을 지능망...
                if let regex = try? NSRegularExpression(pattern: "([0-9]{4})([0-9]{4})", options: .caseInsensitive) { let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2")
                    return modString
                    
                }
                
            } else { // 나머지는 휴대폰번호 (010-xxxx-xxxx, 031-xxx-xxxx, 061-xxxx-xxxx 식이라 상관무)
                if let regex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2-$3")
                    return modString
                    
                }
                
            }
            
        }
        return self
        
    }
    
}

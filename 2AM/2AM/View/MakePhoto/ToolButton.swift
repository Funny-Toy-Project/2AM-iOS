//
//  ToolButton.swift
//  2AM
//
//  Created by 전판근 on 2021/04/26.
//

import UIKit

class ToolButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        configureButton(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError(">> ToolButton : init(coder:) has not been implemented")
    }
    
    private func configureButton(title: String) {
        snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel?.adjustsFontSizeToFitWidth = true
        
        layer.borderWidth = 1
        layer.cornerRadius = 10
        layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0, alpha: 1).cgColor
    }
}

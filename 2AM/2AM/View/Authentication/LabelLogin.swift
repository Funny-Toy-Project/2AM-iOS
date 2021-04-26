//
//  LabelLogin.swift
//  2AM
//
//  Created by 전판근 on 2021/04/26.
//

import UIKit

class LabelLogin: UILabel {
    
    private let labelTitle: UILabel = {
            let lb = UILabel()
            lb.adjustsFontSizeToFitWidth = true
            return lb
        }()
    
    init(title: String) {
        super.init(frame: .zero)
        configureLabel(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError(">> Label Login : init(coder:) has not been implemented")
    }
    
    
    private func configureLabel(title: String) {
        text = "\(title)"
        UIFont.boldSystemFont(ofSize: 24)
    }
}

//
//  ViewController.swift
//  2AM
//
//  Created by 전판근 on 2021/04/25.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    private let myView: UIButton = {
        let v = UIButton()
        v.setTitle("HI", for: .normal)
        v.setTitleColor(.white, for: .normal)
        v.backgroundColor = .blue
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureSubView()
        
    }
    
    func configureView() {
        view.backgroundColor = .white
        print("HOME")
        
        view.addSubview(myView)
        myView.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).offset(100)
            $0.top.equalTo(view.snp.top).offset(100)
        }
        
    }
    
    func configureSubView() {
        
    }


}


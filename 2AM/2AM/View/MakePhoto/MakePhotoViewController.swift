//
//  MakePhotoViewController.swift
//  2AM
//
//  Created by 전판근 on 2021/04/26.
//

import UIKit
import SnapKit

class MakePhotoViewController: UIViewController {
    
    private var imageView: UIImageView = {
        
        let imageArr = ["1.jpeg", "2.jpeg", "3.jpeg", "4.jpeg", "5.jpeg",]
        
        let imageView = UIImageView()
        let myImage = UIImage(named: imageArr.randomElement() ?? "")
        imageView.image = myImage
        
        imageView.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(300)
        }
        return imageView
    }()
    
    override func viewDidLoad() {
        configureView()
        configureSubView()
    }
    
    func configureView() {
        view.backgroundColor = .white
        self.tabBarController?.navigationItem.title = "짤 만들기"
        
        view.addSubview(imageView)
    }
    
    func configureSubView() {
        imageView.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
        }
    }
}

//
//  MyPageViewcontroller.swift
//  2AM
//
//  Created by 전판근 on 2021/04/25.
//

import UIKit
import SnapKit

class MyPageViewController: UIViewController {
    override func viewDidLoad() {
        configureView()
    }
    
    func configureView() {
        print("MyPage")
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.title = "마이페이지"
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc private func addTapped() {
        let photoVC = MakePhotoViewController()
        navigationController?.pushViewController(photoVC, animated: true)
    }
}


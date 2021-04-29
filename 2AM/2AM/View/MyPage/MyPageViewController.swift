//
//  MyPageViewcontroller.swift
//  2AM
//
//  Created by 전판근 on 2021/04/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MyPageViewController: UICollectionViewController {
    
    let images = ["1.jpeg", "2.jpeg", "3.jpeg"]
    
    //MARK:- Private
    private let bag = DisposeBag()
    private let viewModel = LoginViewModel()
    
    private let labelTitle: UILabel = {
        let lb = UILabel()
        lb.text = "유저 아이디"
        lb.textColor = .black
        lb.font = UIFont.boldSystemFont(ofSize: 24)
        
        return lb
    }()
    
    
    private let reuseIdentifier = "Cell"
    private let myCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.red
        return collectionView
    }()
    
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        configureView()
        configureSubView()
        configureNavi()
        
        print("\(viewModel.emailObserver.asDriver())")
        print("\(viewModel.emailObserver.value)")
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        view.addSubview(labelTitle)
        view.addSubview(collectionView)
        myCollectionView.register(ImageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func configureSubView() {
        labelTitle.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
        }
        
        myCollectionView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(0)
            $0.top.equalTo(labelTitle.snp.bottom).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(0)
        }
    }
    
    func configureNavi() {
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



extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCell
        
        cell.myImage.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    // 셀 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collWidth = collectionView.frame.width / 3 - 1
        return CGSize(width: collWidth, height: collWidth)
    }
    
    // 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // 좌우간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
}

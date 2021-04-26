//
//  MakePhotoViewController.swift
//  2AM
//
//  Created by 전판근 on 2021/04/26.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MakePhotoViewController: UIViewController {
    
    //MARK:- Private
    private let bag = DisposeBag()
    
    private var imageView: UIImageView = {
        
        let imageArr = ["1.jpeg", "2.jpeg", "3.jpeg", "4.jpeg", "5.jpeg"]
        
        let imageView = UIImageView()
        let myImage = UIImage(named: imageArr.randomElement() ?? "")
        imageView.image = myImage
        
        imageView.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(300)
        }
        return imageView
    }()
    
    private let btnRefreshPhoto: UIButton = {
        let btn = UIButton()
        btn.setTitle("새로고침", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return btn
    }()
    
    private let btnApply: UIButton = {
        let btn = UIButton()
        btn.setTitle("적용하기", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return btn
    }()
    
    private let btnSaveImage: UIButton = {
        let btn = UIButton()
        btn.setTitle("저장하기", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return btn
    }()
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        configureView()
        configureSubView()
        bindRx()
    }
    
    
    //MARK:- Helpers
    func configureView() {
        view.backgroundColor = .white
        self.tabBarController?.navigationItem.title = "짤 만들기"
        
        view.addSubview(imageView)
        view.addSubview(btnRefreshPhoto)
        view.addSubview(btnApply)
        view.addSubview(btnSaveImage)
    }
    
    func configureSubView() {
        imageView.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
        }
        
        btnRefreshPhoto.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(imageView.snp.bottom).offset(16)
        }
        
        btnApply.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(btnRefreshPhoto.snp.bottom).offset(16)
        }
        
        btnSaveImage.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(btnApply.snp.bottom).offset(16)
        }
        
    }
    
    func bindRx() {
        btnRefreshPhoto.rx
            .tap
            .bind {
                print("새로고침")
                let imageArr = ["1.jpeg", "2.jpeg", "3.jpeg", "4.jpeg", "5.jpeg"]
                let myImage = UIImage(named: imageArr.randomElement() ?? "")
                self.imageView.image = myImage
                
            }
            .disposed(by: bag)
        
        btnApply.rx
            .tap
            .bind { [self] in
                print("적용하기")
                let newImage = textToImage(drawText: "HELLLLO", inImage: imageView.image!, atPoint: CGPoint(x: imageView.bounds.minX, y: imageView.bounds.midY))
                imageView.image = newImage
            }
            .disposed(by: bag)
        
        btnSaveImage.rx
            .tap
            .bind {
                let image = self.imageView.image
                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: image!)
            }
            .disposed(by: bag)
    }
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 30)!

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    
    
}

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
            $0.width.height.equalTo(400)
        }
        return imageView
    }()
    
    private let stackButtons: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let btnRefreshPhoto = ToolButton(title: "새로고침")
    private let btnApply = ToolButton(title: "적용하기")
    private let btnSaveImage = ToolButton(title: "저장하기")
    
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
        
        // 기능 버튼
        view.addSubview(stackButtons)
        [btnRefreshPhoto, btnApply, btnSaveImage].forEach {
            stackButtons.addArrangedSubview($0)
        }
        
    }
    
    func configureSubView() {
        imageView.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        stackButtons.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).offset(8)
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.trailing.equalTo(view.snp.trailing).offset(-8)
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
                let newImage = textToImage(drawText: "안녕, 새벽 두시", inImage: imageView.image!, atPoint: CGPoint(x: 0, y: imageView.bounds.size.height/2))
                imageView.image = newImage
            }
            .disposed(by: bag)
        
        btnSaveImage.rx
            .tap
            .bind {
                let image = self.imageView.image
                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: image!)
                
                let alert = UIAlertController(title: "성공", message: "성공적으로 저장되었습니다.", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                    
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            .disposed(by: bag)
    }
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 30)!

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}

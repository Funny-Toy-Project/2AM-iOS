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
    private var tempImage: UIImage?
    
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
    
    private let tfMytext: UITextField = {
        let tf = UITextField()
        tf.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        tf.placeholder = "감성 문구를 적어주세요!"
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0, alpha: 1).cgColor
        
        tf.addLeftPadding()
        
        return tf
    }()
    
    private let btnRefreshPhoto = ToolButton(title: "새로고침")
    private let btnApply = ToolButton(title: "적용하기")
    private let btnSaveImage = ToolButton(title: "저장하기")
    
    private let btnUpload: UIButton = {
        let btn = UIButton()
        btn.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        btn.setTitle("업로드", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.systemBlue
        
        btn.layer.cornerRadius = 10
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
        tempImage = imageView.image
        
        // 기능 버튼
        view.addSubview(stackButtons)
        [btnRefreshPhoto, btnApply, btnSaveImage].forEach {
            stackButtons.addArrangedSubview($0)
        }
        
        view.addSubview(tfMytext)
        view.addSubview(btnUpload)
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

        tfMytext.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).offset(8)
            $0.top.equalTo(stackButtons.snp.bottom).offset(16)
            $0.trailing.equalTo(view.snp.trailing).offset(-8)
        }
        
        btnUpload.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).offset(8)
            $0.trailing.equalTo(view.snp.trailing).offset(-8)
            $0.bottom.equalTo(view.snp.bottom).offset(-30)
        }
    }
    
    func bindRx() {
        
        var applyText: String = ""
        
        btnRefreshPhoto.rx
            .tap
            .bind {
                print("새로고침")
                let imageArr = ["1.jpeg", "2.jpeg", "3.jpeg", "4.jpeg", "5.jpeg"]
                let myImage = UIImage(named: imageArr.randomElement() ?? "")
                self.imageView.image = myImage
                self.tempImage = myImage
                self.tfMytext.text = ""
            }
            .disposed(by: bag)
        
        btnApply.rx
            .tap
            .bind { [self] in
                print("적용하기")
                imageView.image = tempImage
                let newImage = textToImage(drawText: applyText, inImage: imageView.image!, atPoint: CGPoint(x: 0, y: imageView.bounds.size.height/2))
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
        
        tfMytext.rx
            .text
            .orEmpty
            .skip(1)
            .subscribe(onNext: { changedText in
                applyText = changedText
                print("Changed Text :: \(changedText)")
            })
            .disposed(by: bag)
        
        btnUpload.rx
            .tap
            .bind {
                print("업로드")
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

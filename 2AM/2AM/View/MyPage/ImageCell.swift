//
//  imageCell.swift
//  2AM
//
//  Created by 전판근 on 2021/04/29.
//

import UIKit
import SnapKit

class ImageCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureSubCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("ImageCell :: init(coder:) has not been implemented")
    }
    
    let myImage: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    func configureCell() {
        backgroundColor = .yellow
        addSubview(myImage)
    }
    
    func configureSubCell() {
        myImage.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading)
            $0.top.equalTo(self.snp.top)
            $0.trailing.equalTo(self.snp.trailing)
            $0.bottom.equalTo(self.snp.bottom)
        }
    }
}

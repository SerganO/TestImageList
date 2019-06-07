//
//  UserCell.swift
//  TestImageList
//
//  Created by Trainee on 6/7/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import UIKit
import SnapKit
class UserCell: UITableViewCell {

  
    let userImage = UIImageView()
    let userName = UILabel()
    let imagesView = UIView()
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        
        contentView.addSubview(userImage)
        contentView.addSubview(userName)
        contentView.addSubview(imagesView)
        
        userImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        userImage.layer.cornerRadius = 25
        userImage.layer.masksToBounds = true
        
        userName.snp.makeConstraints { (make) in
            make.centerY.equalTo(userImage)
            make.leading.equalTo(userImage.snp.trailing).offset(10)
            make.height.equalTo(30)
        }
        
        imagesView.snp.makeConstraints { (make) in
            make.top.equalTo(userImage.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    public func configureImages(){
        let count = imagesView.subviews.count
        guard count > 0 else { return }
        if count % 2 == 0 {
            
            for (i,view) in imagesView.subviews.enumerated() {
                if (i % 2 == 0 ) {
                    if i == 0 {
                        
                    } else {
                        
                    }
                    
                } else {
                    
                }
            }
            
            
        } else {
            
        }
    }

}
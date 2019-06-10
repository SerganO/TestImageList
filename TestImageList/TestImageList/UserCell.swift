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
    
    let offset = 10
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
            make.height.equalTo(calculateHeight(10)).priority(999)
        }
    }
    
    public func calculateHeight(_ count: Int) -> CGFloat {
        var height: CGFloat = 0
        let containerWidth = imagesView.frame.width
        if count % 2 == 0 {
            let imagePart = ((containerWidth / 2) - CGFloat(offset / 2)) * CGFloat((count / 2))
            let offsetPart = offset * ((count / 2) - 1)
            height = imagePart + CGFloat(offsetPart)
        } else {
            let imagePart = containerWidth + (containerWidth / 2) * CGFloat(((count - 1) / 2))
            let offsetPart = offset * (((count - 1) / 2) - 1)
            height = imagePart + CGFloat(offsetPart)
        }
        return height
    }
    
    
    public func configureCell() {
        let count = imagesView.subviews.count
        imagesView.snp.updateConstraints { (update) in
            update.height.equalTo(calculateHeight(count)).priority(999)
        }
        let isEven = count % 2 == 0
        var lastView = UIView()
        for (i,view) in imagesView.subviews.enumerated() {
            if i == 0 {
                if isEven {
                    view.snp.makeConstraints { (make) in
                        make.top.equalToSuperview()
                        make.leading.equalToSuperview()
                        make.width.equalToSuperview().multipliedBy(0.5).offset(-5)
                        make.height.equalTo(view.snp.width)
                    }
                } else {
                    view.snp.makeConstraints { (make) in
                        make.top.equalToSuperview()
                        make.leading.equalToSuperview()
                        make.width.equalToSuperview()
                        make.height.equalTo(view.snp.width)
                    }
                }
                lastView = view
            } else {
                var isIndexEven = i % 2 == 0
                if !isEven {
                    isIndexEven = !isIndexEven
                }
                
                
                view.snp.makeConstraints { (make) in
                   
                    if isIndexEven {
                        make.leading.equalToSuperview()
                        make.top.equalTo(lastView.snp.bottom).offset(offset)
                    } else {
                        make.trailing.equalToSuperview()
                        make.top.equalTo(lastView)
                    }
                    
                    make.width.equalToSuperview().multipliedBy(0.5).offset(-5)
                    make.height.equalTo(view.snp.width)
                    
                }
                
                if isIndexEven {
                    lastView = view
                }
            }
        }
        imagesView.subviews.last?.snp.makeConstraints({ (make) in
            make.bottom.equalToSuperview()
        })
    }
}

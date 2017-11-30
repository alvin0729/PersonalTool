//
//  CollapsibleTableViewCell.swift
//  ALPersonalSwiftTool
//
//  Created by 懂懂科技 on 2017/11/29.
//  Copyright © 2017年 company. All rights reserved.
//

import UIKit

class CollapsibleTableViewCell: UITableViewCell {
    let nameLable = UILabel()
    let detailLable = UILabel()
    
    //MARK: Initalizers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(nameLable)
        nameLable.translatesAutoresizingMaskIntoConstraints = false
        nameLable.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        nameLable.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        nameLable.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        nameLable.numberOfLines = 0
        nameLable.font = UIFont.systemFont(ofSize: 16)
        
        contentView.addSubview(detailLable)
        detailLable.lineBreakMode = .byWordWrapping
        detailLable.translatesAutoresizingMaskIntoConstraints = false
        detailLable.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        detailLable.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        detailLable.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        detailLable.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: 5).isActive = true
        detailLable.numberOfLines = 0
        detailLable.font = UIFont.systemFont(ofSize: 12)
        detailLable.textColor = UIColor.lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  TopTableViewCell.swift
//  ALPersonalSwiftTool
//
//  Created by 懂懂科技 on 2017/11/29.
//  Copyright © 2017年 company. All rights reserved.
//

import UIKit

let kStatusBarHeight :CGFloat = UIApplication.shared.statusBarFrame.size.height
let kNavigationBarHeight :CGFloat = 44.0
let kNavigationAndStatusBarHeight :CGFloat = (kStatusBarHeight + 44.0)
let kScreenW = UIScreen.main.bounds.width

class TopTableViewCell: UITableViewCell {
    lazy var nameLabel = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureUI () {
        nameLabel.frame = CGRect(x: 0, y: 0, width: kScreenW / 4, height: kNavigationAndStatusBarHeight)
        print(nameLabel.frame)
        
        nameLabel.font = UIFont.systemFont(ofSize: 15)
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        contentView.backgroundColor = selected ? UIColor.gray : UIColor(white: 0, alpha: 0.1)
        isHighlighted = selected
        nameLabel.isHighlighted = selected
    }
}

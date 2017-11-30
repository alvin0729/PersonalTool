//
//  GroupHeaderView.swift
//  ALPersonalSwiftTool
//
//  Created by 懂懂科技 on 2017/11/29.
//  Copyright © 2017年 company. All rights reserved.
//

import UIKit

class GroupHeaderView: UITableViewHeaderFooterView {
    
//    var bigGroupsModel : BigGroupsModel?{
//        didSet {
//            //校验模型是否有值
//            guard let bigGroupsModel = bigGroupsModel else {return}
//            titleLabel.text = bigGroupsModel.nameGroup
//            if bigGroupsModel.isOpenGroup {
//                iconImg.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
//            } else {
//                 iconImg.transform = CGAffineTransform(rotationAngle: CGFloat(0))
//
//            }
//        }
//
//    }

    weak var groupHeaderView:UITableViewHeaderFooterView!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    convenience init(){
        self.init(frame:CGRect.zero)
        setupSubviews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
}

func setupSubviews(){
    //initialize my subviews
    let button = UIButton()
    button.backgroundColor = UIColor.red
    button.titleLabel?.text = "哈哈"
}

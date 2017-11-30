//
//  JobSummaryController.swift
//  ALPersonalSwiftTool
//
//  Created by 懂懂科技 on 2017/11/29.
//  Copyright © 2017年 company. All rights reserved.
//

import UIKit

private let kCellIdentify = "kCellIdentify"

class JobSummaryController: UIViewController {
    lazy var bigGroupsModel :[BigGroupsModel] = [BigGroupsModel]()
    let arr = ["宝贝","详情","评价","推荐"]
    fileprivate var selectIndex = 0
    fileprivate var isScrollDown = true
    fileprivate var lastOffsetY : CGFloat = 0.0
    
    
    
}

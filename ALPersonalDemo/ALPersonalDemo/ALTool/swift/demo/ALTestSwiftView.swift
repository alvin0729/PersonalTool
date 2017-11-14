//
//  ALTestSwiftView.swift
//  ALPersonalDemo
//
//  Created by Alvin on 2017/11/13.
//  Copyright © 2017年 company. All rights reserved.
//

import Foundation
import UIKit

public // OC 调用 Swift
class SWView: UIView {
    
    func comeOn() -> () {
        
        print("come on")
    }
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() -> () {
        
        backgroundColor = UIColor.red
    }
    
}

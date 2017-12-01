//
//  FriendsModel.swift
//  ALPersonalSwiftTool
//
//  Created by 懂懂科技 on 2017/11/29.
//  Copyright © 2017年 company. All rights reserved.
//

import Foundation

class BigGroupModel: NSObject {
    @objc var nameGroup : String = ""
    @objc var online : NSNumber = 1
    var isOpenGroup = false
    
    @objc lazy var friendsModel : [FriendsModel] = [FriendsModel]()
    
    @objc var friends : [[String : NSObject]]?{
        didSet{
            guard let friends = friends else{
                return
            }
            for dict in friends {
                friendsModel.append(FriendsModel(dic: dict))
            }
        }
    }
}

class FriendsModel: BigGroupModel {
    @objc var vip : NSNumber = 1
    @objc var icon : String = ""
    @objc var intro : String = ""
    @objc var name : String = ""
    
    //自定义字典转模型的构造函数
    init(dic:[String : Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        return
    }
    
}

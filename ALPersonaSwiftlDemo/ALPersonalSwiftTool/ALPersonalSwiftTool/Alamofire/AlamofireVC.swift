//
//  AlamofireVC.swift
//  ALPersonalSwiftTool
//
//  Created by Alvin on 2018/12/9.
//  Copyright © 2018年 company. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension AlamofireVC{
    fileprivate func setupUI(){
        view.backgroundColor = UIColor.white
    }
}

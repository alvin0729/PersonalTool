//
//  ALTestSwiftOneVC.swift
//  ALPersonalDemo
//
//  Created by Alvin on 2017/11/13.
//  Copyright © 2017年 company. All rights reserved.
//

import Foundation
import UIKit

/**
 代理 要使用objc oc中才能获取到
 */
@objc(ALEditTextFiledDelegate)
protocol editTextFiledDelegate: NSObjectProtocol {
    
    func editTextfiledDele( str: String) -> Void
}
// 1.定义一个闭包类型
//格式: typealias 闭包名称 = (参数名称: 参数类型) -> 返回值类型
typealias swiftBlock = (_ str: String) -> Void
class ALTestSwiftVC: UIViewController {
    
    /**
     参数设置成public 可以在oc中传递参数
     */
    public var proId:String = ""
    public var model:String = ""
    
    /**
     声明代理
     */
    var textfileddelegate:editTextFiledDelegate?
    
    /**
     定义block
     */
    typealias edittextfileBlock = ( _ str: String) -> Void
    //2. 声明一个变量
    var callBack: swiftBlock?
    var myeditBlock:edittextfileBlock?
    func buttonClick() {
        //4. 调用闭包,设置你想传递的参数,调用前先判定一下,是否已实现
        if callBack != nil {
            // 5. 实现闭包,获取到传递的参数
            //other.callBackBlock { (str) in
                //print(str)
            //}
            callBack!("这里的闭包传递了一个字符串")
        }
    }
    
    //3. 定义一个方法,方法的参数为和swiftBlock类型一致的闭包,并赋值给callBack
    func callBackBlock(_ block: @escaping swiftBlock) {
        callBack = block
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.brown
        
        print("-----testSwiftviewController---")
        
        print("------proId:\(proId)------modle:\(model))")
        
        self.view.addSubview(testTextfiled)
        self.view.addSubview(testbtn)
    }
    
    func backbtn() {
        
        testTextfiled.resignFirstResponder()
        
        if textfileddelegate != nil {
            
            textfileddelegate?.editTextfiledDele(str: testTextfiled.text!)
        }
        
        if self.myeditBlock != nil {
            
            self.myeditBlock?(testTextfiled.text!)
        }
        self.navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    
    /**
     使用方法传递参数
     */
    public func modele(modele:String) -> () {
        
        model = modele
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        testTextfiled.resignFirstResponder()
    }
    
    
    
    /**
     懒加载
     */
    lazy var testTextfiled: UITextField = {
        let testTextfiled = UITextField.init(frame: CGRect(x:100,y:100,width:100,height:50))
        testTextfiled.placeholder = "输入..."
        return testTextfiled
    }()
    
    lazy var testbtn: UIButton = {
        let testbtn = UIButton.init(frame: CGRect(x:100,y:100,width:100,height:100))
        testbtn.setTitle("返回", for: .normal)
        testbtn.addTarget(self, action: #selector(backbtn), for: .touchUpInside)
        testbtn.center = self.view.center
        return testbtn
    }()
}

//
//  10daysDemoVC.swift
//  ALPersonalSwiftTool
//
//  Created by Alvin on 2018/12/9.
//  Copyright © 2018年 company. All rights reserved.
//

import UIKit

class TendaysDemoVC: UIViewController {
    let label = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ///customFont
        setupUI()
        var dic: NSDictionary?
        var test =  kFilterNullOfDictionary(dic)
        print("-----3333333- \(test) ")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}

extension TendaysDemoVC{
    fileprivate func setupUI(){
        view.backgroundColor = UIColor.white
        label.text = "I am the king of the world"
        label.textAlignment = NSTextAlignment.center;
        view.addSubview(label);
        label.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 50);
        label.font = UIFont.systemFont(ofSize: 30)
        
        let changeBtn = UIButton(type: .custom)
        changeBtn.setTitle("Change Font Family", for: .normal)
        changeBtn.addTarget(self, action: #selector(changeFontFamily), for: .touchUpInside)
        changeBtn.setTitleColor(UIColor.blue, for: .normal)
        view.addSubview(changeBtn)
        changeBtn.layer.borderColor = UIColor.blue.cgColor
        changeBtn.layer.borderWidth = 1
        changeBtn.frame = CGRect(x: kScreenWidth / 2.0 - 100, y: 500, width: 200, height: 30)
        
        printAllSupportedFontNames()
    }
    
    @objc func changeFontFamily(){
        label.font = UIFont(name: "Savoye LET", size: 30)
    }
    
    func printAllSupportedFontNames(){
        let familyNames = UIFont.familyNames
        for familyName in familyNames {
            print("+++++ \(familyName)")
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            for fontName in fontNames{
                print("---- \(fontName)")
            }
        }
    }
}







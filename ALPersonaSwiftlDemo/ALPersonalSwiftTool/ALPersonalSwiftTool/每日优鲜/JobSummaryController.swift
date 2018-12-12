//
//  JobSummaryController.swift
//  ALPersonalSwiftTool
//
//  Created by 懂懂科技 on 2017/11/29.
//  Copyright © 2017年 company. All rights reserved.
//

import UIKit

private let kCellIdentify = "kCellIdentify"
let kTopTableViewCell = "TopTableViewCell"

class JobSummaryController: UIViewController{
    lazy var bigGroupsModel :[BigGroupModel] = [BigGroupModel]()
    let arr = ["宝贝","详情","评价","推荐"]
    fileprivate var selectIndex = 0
    fileprivate var isScrollDown = true
    fileprivate var lastOffsetY : CGFloat = 0.0
    
    fileprivate lazy var bottomTableView : UITableView = {[unowned self] in
        let bottomTableView = UITableView(frame: CGRect(x:0, y:64+kNavigationAndStatusBarHeight,width:self.view.bounds.width, height: self.view.bounds.height - kNavigationAndStatusBarHeight * 3), style: .grouped)
        bottomTableView.dataSource = self;
        bottomTableView.delegate = self;
        return bottomTableView
    }()
    
    fileprivate lazy var topTableView: UITableView = {
        let topTableView = UITableView(frame:CGRect(x: 0, y: self.view.frame.size.height / 2 - kNavigationAndStatusBarHeight, width: kNavigationAndStatusBarHeight, height: self.view.frame.size.height - kNavigationAndStatusBarHeight))
        topTableView.delegate = self
        topTableView.dataSource = self
        
        topTableView.rowHeight = kScreenW / 4
        //print(topTableView.rowHeight)
        topTableView.showsVerticalScrollIndicator = false
        topTableView.backgroundColor = UIColor.green
        topTableView.register(TopTableViewCell.self, forCellReuseIdentifier: kTopTableViewCell)
        
        topTableView.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        topTableView.frame =  CGRect(x: 0, y: kNavigationAndStatusBarHeight, width:self.view.frame.size.height - kNavigationAndStatusBarHeight , height:kNavigationAndStatusBarHeight )
        return topTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initData()
    }
    
}

extension JobSummaryController{
    fileprivate func setupUI(){
        view.addSubview(bottomTableView)
        view.addSubview(topTableView)
        view.backgroundColor = UIColor.white
        topTableView.selectRow(at: IndexPath(row: 0, section:0), animated: true, scrollPosition: .none)
    }
}

extension JobSummaryController{
    fileprivate func initData(){
        guard let jsonPath:String = Bundle.main.path(forResource: "demo.json", ofType: nil) else {
            return
        }
        guard let jsonData = NSData(contentsOfFile: jsonPath) else {
            return
        }
        guard let anyObject = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) else {
            return
        }
        guard let dataArray = anyObject as? [[String:AnyObject]] else {
            return
        }
        for dict in dataArray {
            self.bigGroupsModel.append(FriendsModel(dic: dict))
        }
        bottomTableView.sectionHeaderHeight = 40
        bottomTableView.register(GroupHeaderView.self, forHeaderFooterViewReuseIdentifier: "kGroupHeaderView")
    }
}


extension JobSummaryController:UITableViewDataSource,UITableViewDelegate{
    
    // TableView 分区标题即将展示
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        // 当前的 tableView 是 bottomTableView，bottomTableView 滚动的方向向上，bottomTableView 是用户拖拽而产生滚动的（（主要判断 bottomTableView 用户拖拽而滚动的，还是点击 topTableView 而滚动的）
        if bottomTableView == tableView && !isScrollDown && (bottomTableView.isDragging || bottomTableView.isDecelerating){
            selectRow(index: section)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
         // 当前的 tableView 是 bottomTableView，bottomTableView 滚动的方向向下，bottomTableView 是用户拖拽而产生滚动的（（主要判断 bottomTableView 用户拖拽而滚动的，还是点击 topTableView 而滚动的）
        if (bottomTableView == tableView)
            && isScrollDown
            && (bottomTableView.isDragging || bottomTableView.isDecelerating) {
            selectRow(index: section + 1 )
        }
    }
    
    // 当拖动右边 TableView 的时候，处理左边 TableView
    private func selectRow(index : Int) {
        print("下标"+" --- \(String(describing:index))")
        if index <= arr.count - 1 {
            topTableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .top)
            
            /*
             如果标题比较多
             if index == arr.count - 1 {
             let contentInsets:UIEdgeInsets = UIEdgeInsetsMake(-kNavigationAndStatusBarHeight, 0.0, 0, 0.0);
             self.topTableView.contentInset = contentInsets
             } else {
             let contentInsets:UIEdgeInsets = UIEdgeInsetsMake(0, 0.0, 0, 0.0);
             self.topTableView.contentInset = contentInsets
             
             }
             */
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if topTableView == tableView {
            selectIndex = indexPath.row
            self.scrollToTop(section: selectIndex, animated: true)
            topTableView.scrollToRow(at: IndexPath(row: selectIndex, section: 0), at: .top, animated: true)
        }else{
            if(indexPath.section == 3){
                if(indexPath.row == 0){
                    navigationController?.pushViewController(AlamofireVC(), animated: true)
                }
                if(indexPath.row == 1){
                   navigationController?.pushViewController(TendaysDemoVC(), animated: true)
                }
                if(indexPath.row == 2){
                    let vc = SwiftyJSONTestVC()
                    if let file = Bundle.main.path(forResource: "SwiftyJSONTests", ofType: "json"){
                        do{
                            let data = try Data(contentsOf: URL(fileURLWithPath: file))
                            let json = try JSON(data:data)
                            vc.json = json
                        }catch{
                            vc.json = JSON.null
                        }
                    }else{
                        vc.json = JSON.null
                    }
                    
                    navigationController?.pushViewController(vc, animated: true)
                }
                
                if(indexPath.row == 3){
                    navigationController?.pushViewController(ALCodableVC(), animated: true)
                }
            }
            
        }
        
    }
    fileprivate func scrollToTop(section: Int, animated: Bool) {
        let headerRect = bottomTableView.rect(forSection:section)
        let topOfHeader = CGPoint(x: 0, y: headerRect.origin.y - bottomTableView.contentInset.top)
        bottomTableView.setContentOffset(topOfHeader, animated: animated)
    }
    // 标记一下 bottomTableView 的滚动方向，是向上还是向下
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let tableView = scrollView as! UITableView
        if bottomTableView == tableView {
            isScrollDown = lastOffsetY < scrollView.contentOffset.y
            lastOffsetY = scrollView.contentOffset.y
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if topTableView == tableView {
            return 1
        } else {
            return self.bigGroupsModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.bigGroupsModel[section].isOpenGroup ? self.bigGroupsModel[section].friendsModel.count : 0
        
        if topTableView == tableView {
            return arr.count
        } else {
            return  self.bigGroupsModel[section].friendsModel.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if topTableView == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: kTopTableViewCell, for: indexPath) as! TopTableViewCell
            cell.selectionStyle = .none
            cell.nameLabel.text = arr[indexPath.row]
            cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
            
            return cell
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentify)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: kCellIdentify)
            }
            
            cell?.imageView?.image = UIImage(named: self.bigGroupsModel[indexPath.section].friendsModel[indexPath.row].icon)
            cell?.textLabel?.text = self.bigGroupsModel[indexPath.section].friendsModel[indexPath.row].name
            return cell!
            
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if topTableView == tableView {
            return 0
        } else {
            return  40
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if topTableView == tableView {
            return nil
        } else {
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 40))
            btn.backgroundColor = UIColor.groupTableViewBackground
            btn.contentHorizontalAlignment = .left
            
            btn.setImage(UIImage(named: "sanjiao"), for: .normal)
            //修改图片的模式
            btn.imageView?.contentMode = .center
            //让多出来的部分不要切割
            btn.imageView?.clipsToBounds = false
            
            btn.setTitle(self.bigGroupsModel[section].nameGroup, for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            //显示文字的边距
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            
            //修改按钮的内边距
            btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
            btn.tag = section;
            return btn
        }
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if topTableView == tableView {
            return 0
        } else {
            return  1
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if topTableView == tableView {
            return nil
        } else {
            let viewM = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 1))
            return viewM
            
        }
    }
}





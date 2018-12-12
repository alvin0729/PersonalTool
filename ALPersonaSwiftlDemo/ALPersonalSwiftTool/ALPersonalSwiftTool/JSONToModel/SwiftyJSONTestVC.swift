//
//  SwiftyJSONTestVC.swift
//  ALPersonalSwiftTool
//
/**
 let json = JSON(data: dataFromNetworking)
 if let userName = json[0]["user"]["name"].string{
    //就这么简单取到了。
 }
 */
//  Created by 懂懂科技 on 2018/12/11.
//  Copyright © 2018年 company. All rights reserved.
//

import UIKit

class SwiftyJSONTestVC: UITableViewController {
    
    var json: JSON = JSON.null

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        title = "SwiftyJSON(\(json.type))"
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.json.type {
        case .array, .dictionary:
            return self.json.count
        default:
            return 1
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as UITableViewCell
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "reuseIdentifier")
        
        let row = indexPath.row
        switch self.json.type {
        case .array:
            cell.textLabel?.text = "\(row)"
            cell.detailTextLabel?.text = self.json.arrayValue.description
        case .dictionary:
            let key: Any = Array(self.json.dictionaryValue.keys)[row]
            let value = self.json[key as! String]
            cell.textLabel?.text = "\(key)"
            cell.detailTextLabel?.text = value.description
        default:
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = self.json.description
        }
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC: SwiftyJSONTestVC = SwiftyJSONTestVC()
        
        let row = indexPath.row
        var nextJson: JSON = JSON.null
        switch self.json.type {
        case .array:
            nextJson = self.json[row]
        case .dictionary where row < self.json.dictionaryValue.count:
            let key = Array(self.json.dictionaryValue.keys)[row]
            if let value = self.json.dictionary?[key]{
                nextJson = value
            }
        default:
            print("")
        }
        nextVC.json = nextJson
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    

}

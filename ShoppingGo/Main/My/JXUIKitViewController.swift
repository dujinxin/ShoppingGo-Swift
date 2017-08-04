//
//  JXUIKitViewController.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/7/28.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

private let cellId = "cellId"
class JXUIKitViewController: JXTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.frame = CGRect.init(x: 0, y: kNavStatusHeight, width: kScreenWidth, height: kScreenHeight - kTabBarHeight)
        //self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        self.tableView?.sectionFooterHeight = 0.1
        self.tableView?.tableFooterView = UIView()//group类型，设置高度不起作用
        //FIXME 对于代码布局貌似不起作用，有待继续探索
        //self.tableView?.rowHeight = UITableViewAutomaticDimension
        //self.tableView?.estimatedRowHeight = 80
        self.tableView?.rowHeight = 60
        requestData()
    }
    
}
extension JXUIKitViewController {
    override func tableView(_ tvareView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
            cell?.detailTextLabel?.numberOfLines = 0
            cell?.detailTextLabel?.sizeToFit()
            cell?.accessoryType = .disclosureIndicator
        }
        
        if
            let dict = dataArray[indexPath.row] as? Dictionary<String,String>,
            let title = dict["title"],
            let detail = dict["detail"],
            let imageName = dict["image"]
        {
            cell?.textLabel?.text = LanguageManager.localizedString(title)
            cell?.detailTextLabel?.text = detail
            cell?.imageView?.image = UIImage(named: imageName)
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let v : UIView?
        
        switch indexPath.row {
        case 0:
            //navigationController?.pushViewController(JXBezierViewController(), animated: true)
            
            v = JXImageView()
            v?.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth / 2)
            v?.backgroundColor = UIColor.white
            let select = JXSelectView(frame: CGRect(), customView: v!)
            
            select.position = .middle
            select.show()
        case 1:
            v = JXStringView()
            v?.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth / 2)
            v?.backgroundColor = UIColor.white
            let select = JXSelectView(frame: CGRect(), customView: v!)
            
            select.position = .middle
            select.show()
        case 2:
            navigationController?.pushViewController(JXBezierViewController(), animated: true)
        case 3:
            navigationController?.pushViewController(JXBezierViewController(), animated: true)
        default:
            break
        }
    }
}
extension JXUIKitViewController {
    
    
    override func setUpDefaultView() {
        
    }
    override func requestData() {
        updateMainView()
    }
    override func updateMainView() {
        self.dataArray.removeAll()
        self.dataArray = [
            ["title":"UIImage",
             "detail":"绘制图片",
             "image":"list_icon_record"],
            ["title":"NSString",
             "detail":"绘制文本",
             "image":"list_icon_collect"],
            ["title":"UIBezierPath",
             "detail":"绘制形状",
             "image":"list_icon_collect"],
            ["title":"UIColor",
             "detail":"绘制颜色",
             "image":"list_icon_collect"],
        ]
        self.tableView?.reloadData()
    }
}

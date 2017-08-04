//
//  JXDrawViewController.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/7/28.
//  Copyright © 2017年 杜进新. All rights reserved.
//
/// 绘图 UIKit和Core Graphics
import UIKit

private let cellId = "cellId"
class JXDrawViewController: JXTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.frame = CGRect.init(x: 0, y: kNavStatusHeight, width: kScreenWidth, height: kScreenHeight - kTabBarHeight)
        //self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        self.tableView?.sectionFooterHeight = 0.1
        self.tableView?.tableFooterView = UIView()//group类型，设置高度不起作用
        //FIXME 对于代码布局貌似不起作用，有待继续探索
        //self.tableView?.rowHeight = UITableViewAutomaticDimension
        //self.tableView?.estimatedRowHeight = 80
        self.tableView?.rowHeight = 80
        requestData()
    }
    
}
extension JXDrawViewController {
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
        
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(JXUIKitViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(JXBezierViewController(), animated: true)
        default:
            break
        }
    }
}
extension JXDrawViewController {
    
    
    override func setUpDefaultView() {
        
    }
    override func requestData() {
        updateMainView()
    }
    override func updateMainView() {
        self.dataArray.removeAll()
        self.dataArray = [
            ["title":"UIKit",
             "detail":"UIImage、NSString（绘制文本）、UIBezierPath（绘制形状）、UIColor",
             "image":"list_icon_record"],
            ["title":"Core Graphics",
             "detail":"绘图专用的API族，它经常被称为QuartZ或QuartZ 2D。Core Graphics是iOS上所有绘图功能的基石，包括UIKit。",
             "image":"list_icon_collect"],
        ]
        self.tableView?.reloadData()
    }
}


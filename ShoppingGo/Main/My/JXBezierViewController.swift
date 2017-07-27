//
//  JXBezierViewController.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/7/20.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit
private let cellId = "cellId"
class JXBezierViewController: JXTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView?.frame = CGRect.init(x: 0, y: kNavStatusHeight, width: kScreenWidth, height: kScreenHeight - kTabBarHeight)
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)

        self.tableView?.sectionFooterHeight = 0.1
        self.tableView?.tableFooterView = UIView()//group类型，设置高度不起作用
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView?.estimatedRowHeight = 44*kPercent
        
        requestData()
    }

}
extension JXBezierViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        if
            let dict = dataArray[indexPath.row] as? Dictionary<String,String>,
            let title = dict["title"],
            let imageName = dict["image"]
        {
            //cell.textLabel?.text = LanguageManager.manager.localizedString(title)
            cell.textLabel?.text = LanguageManager.localizedString(title)
            cell.imageView?.image = UIImage(named: imageName)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let v : UIView
        
//        switch indexPath.row {
//        case 0:
//            
//        default:
//            <#code#>
//        }
//        
//        
//        let select = JXSelectView(frame: CGRect.init(x: 0, y: 0, width: 300, height: 300), customView: <#T##UIView#>)
//        
//        let alert = JXAlertView(frame: CGRect.init(x: 0, y: 0, width: 300, height: 300), style: .custom)
//        
//        alert.show()
        
    }
}
extension JXBezierViewController {
    
    
    override func setUpDefaultView() {
        
    }
    override func requestData() {
        updateMainView()
    }
    override func updateMainView() {
        self.dataArray.removeAll()
        self.dataArray = [
                //{"title":"Coupons","image":"list_icon_privilege"},
                ["title":"Records","image":"list_icon_record"],
                ["title":"Favorites","image":"list_icon_collect"],
                ["title":"Level","image":"list_icon_level"],
                ["title":"Follower","image":"list_icon_fans"],
                ["title":"Share","image":"list_icon_friends_share"],
                ["title":"Settings","image":"list_icon_setting"],
                ["title":"Help","image":"list_icon_help"],
                ["title":"OpenShop","image":"list_icon_open_shop"],
                ["title":"Invitation","image":"list_icon_invitation"],
                ["title":"Service","image":"list_icon_phon"]
        ]
        self.tableView?.reloadData()
    }
}

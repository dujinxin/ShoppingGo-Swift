//
//  JXSettingViewController.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/8/4.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class JXSettingViewController: JXTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "设置"
        
        self.style = .grouped
        self.tableView?.frame = CGRect.init(x: 0, y: kNavStatusHeight, width: kScreenWidth, height: kScreenHeight - kNavStatusHeight)
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)

        self.tableView?.sectionHeaderHeight = 10 //group类型，第一分区不起做用，需要通过代理方法设置
        self.tableView?.sectionFooterHeight = 0.1
        self.tableView?.tableFooterView = UIView()//group类型，设置高度不起作用
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView?.estimatedRowHeight = 44*kPercent
        
        self.requestData()
    }
}

extension JXSettingViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataArray[section] as! Array<Any>).count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        if
            let array = dataArray[indexPath.section] as? Array<Dictionary<String,String>>,
            let title = array[indexPath.row]["title"],
            let imageName = array[indexPath.row]["image"]
        {
            //cell.textLabel?.text = LanguageManager.manager.localizedString(title)
            cell.textLabel?.text = LanguageManager.localizedString(title)
            cell.imageView?.image = UIImage(named: imageName)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //SLComposeViewController
        if indexPath.section == 0 {
            self.navigationController?.pushViewController(JXAddressListController(), animated: true)
        }else if indexPath.section == 1{
            self.navigationController?.pushViewController(JXDBListViewController(), animated: true)
        }else if indexPath.section == 2 {
            self.navigationController?.pushViewController(JXFeedbackViewController(), animated: true)
        } else {
            
        }
    }
}
//MARK: - override super func
extension JXSettingViewController {
    
    override func requestData() {
        updateMainView()
    }
    override func updateMainView() {
        self.dataArray.removeAll()
        self.dataArray = [
            [
                //{"title":"Coupons","image":"list_icon_privilege"},
                ["title":"订单管理","image":"list_icon_record"],
                ["title":"收藏管理","image":"list_icon_collect"],
                ["title":"地址管理","image":"list_icon_level"]
            ],
            [
                ["title":"FMDB","image":"list_icon_fans"],
                ["title":"CoreData","image":"list_icon_friends_share"]
            ],
            [
                ["title":"Settings","image":"list_icon_setting"],
                ["title":"Help","image":"list_icon_help"]
            ],
            [
                ["title":"OpenShop","image":"list_icon_open_shop"],
                ["title":"Invitation","image":"list_icon_invitation"]
            ],
            [
                ["title":"Service","image":"list_icon_phon"],
                ]
        ]
        self.tableView?.reloadData()
    }
}

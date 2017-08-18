//
//  JXUserInfoViewController.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/8/17.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class JXUserInfoViewController: JXTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "个人设置"
        
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

extension JXUserInfoViewController {
    
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
        if indexPath.section > 0 {
            cell.accessoryType = .disclosureIndicator
        }
        cell.contentView.removeAllSubView()
        
        if let array = dataArray[indexPath.section] as? Array<String>{
            cell.textLabel?.text = array[indexPath.row]
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: kScreenWidth - 64, y: 5, width: 34, height: 34)
            imageView.jx_setImage(obj: JXUserDB.shareInstance.userModel.UserImage)
            cell.contentView.addSubview(imageView)
        }else{
            let label = UILabel()
            label.frame = CGRect(x: 100, y: 0, width: kScreenWidth - 130, height: cell.contentView.bounds.height)
            label.textAlignment = .right
            label.textColor = JX999999Color
            cell.contentView.addSubview(label)
            
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    label.text = JXUserDB.shareInstance.userModel.PhoneNumber
                }else{
                    label.text = "\(JXUserDB.shareInstance.userModel.UserID)"
                }
            }else{
                if indexPath.row == 1 {
                    label.text = JXUserDB.shareInstance.userModel.UserName
                }else if indexPath.row == 2 {
                    if JXUserDB.shareInstance.userModel.UserGender == 0{
                        label.text = "男"
                    }else{
                        label.text = "女"
                    }
                }
            }
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 1 {
            var alertVC : UIAlertController?
            if indexPath.row == 0 {
                //
            }else if indexPath.row == 1{
                alertVC = UIAlertController(title: "修改昵称", message: nil, preferredStyle: .alert)
                //键盘的返回键 如果只有一个非cancel action 那么就会触发 这个按钮，如果有多个那么返回键只是单纯的收回键盘
                alertVC?.addTextField(configurationHandler: { (textField) in
                    textField.text = JXUserDB.shareInstance.userModel.UserName
                })
                alertVC?.addAction(UIAlertAction(title: "确定", style: .destructive, handler: { (action) in
                    
                    if
                        let textField = alertVC?.textFields?[0],
                        let text = textField.text,
                        text.isEmpty == false,
                        JXUserDB.shareInstance.modify(name: text){
                        self.tableView?.reloadRows(at: [indexPath], with: .automatic)
                    }
                }))
                alertVC?.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
                }))
            }else{
                alertVC = UIAlertController(title: "请选择性别", message: nil, preferredStyle: .alert)
                alertVC?.addAction(UIAlertAction(title: "男", style: .destructive, handler: { (action) in
                    if JXUserDB.shareInstance.modify(gender: "0"){
                        self.tableView?.reloadRows(at: [indexPath], with: .automatic)
                    }
                }))
                alertVC?.addAction(UIAlertAction(title: "女", style: .destructive, handler: { (action) in
                    if JXUserDB.shareInstance.modify(gender: "1"){
                        self.tableView?.reloadRows(at: [indexPath], with: .automatic)
                    }
                }))
            }
            self.present(alertVC!, animated: true, completion: nil)
        } else {
            
        }
        
    }
}
//MARK: - override super func
extension JXUserInfoViewController {
    
    override func requestData() {
        updateMainView()
    }
    override func updateMainView() {
        self.dataArray.removeAll()

        self.dataArray = [
            ["当前账号","ID"],
            ["头像","昵称","性别"]
        ]
        self.tableView?.reloadData()
    }
}

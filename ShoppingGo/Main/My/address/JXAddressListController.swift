//
//  JXAddressListController.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/8/10.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class JXAddressListController: JXTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "地址管理"
        self.customNavigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(edit(isEidt:index:)))
        
        self.tableView?.frame = CGRect.init(x: 0, y: kNavStatusHeight, width: kScreenWidth, height: kScreenHeight - kNavStatusHeight)
        
        self.tableView?.register(UINib.init(nibName: "JXAddressCell", bundle: nil), forCellReuseIdentifier: cellId)
        self.tableView?.sectionFooterHeight = 0.1
        self.tableView?.tableFooterView = UIView()//group类型，设置高度不起作用
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView?.estimatedRowHeight = 44*kPercent
        
        
        self.requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func edit(isEidt:Bool = false,index:Int) {
        let editVC = JXEditAddressController()
        if isEidt {
            editVC.title = "编辑地址"
            editVC.addressEntity = self.dataArray[index] as? JXAddressEntity
            editVC.editBlock = { entity in
                let range = Range(index..<(index + 1))
                self.dataArray.replaceSubrange(range, with: [entity])
                self.tableView?.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: .automatic)
            }
        }else{
            editVC.title = "新增地址"
            editVC.addBlock = {
                
            }
        }
        
        self.navigationController?.pushViewController(editVC, animated: true)
    }
}

extension JXAddressListController {
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! JXAddressCell
        
        let addressEntity = dataArray[indexPath.row] as! JXAddressEntity
        cell.model = addressEntity
        
        cell.defaultBlock = {
            guard var array = self.dataArray as? Array<JXAddressEntity> else {
                return
            }
            for model in array{
                model.isDefault = 0
            }
            let model = array[indexPath.row]
            model.isDefault = 1
            let range = Range(indexPath.row..<(indexPath.row + 1))
            array.replaceSubrange(range, with: [model])
            
            tableView.reloadData()
        }
        cell.editBlock = {
            self.edit(isEidt: true, index: indexPath.row)
        }
        cell.deleteBlock = {
            self.dataArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //SLComposeViewController
        if indexPath.section == 0 {
            self.showLoadView()
            self.hideLoadView()
        }else if indexPath.section == 1{
            self.showNotice(notice: "测试显示文字")
        }else if indexPath.section == 2 {
            self.navigationController?.pushViewController(JXFeedbackViewController(), animated: true)
        } else {
            
        }
    }
}
//MARK: - override super func
extension JXAddressListController {
    
    override func requestData() {
        updateMainView()
    }
    override func updateMainView() {
        let array = [
            ["name":"阿杜","phone":"13121273641","address":"北京市朝阳区高碑店通惠家园2202","isDefault":0],
            ["name":"阿杜","phone":"13121273641","address":"北京市朝阳区高碑店通惠家园2202","isDefault":1],
            ["name":"阿杜","phone":"13121273641","address":"北京市朝阳区高碑店通惠家园2202","isDefault":0],
            ["name":"阿杜","phone":"13121273641","address":"北京市朝阳区高碑店通惠家园2202","isDefault":0]
        ]
        self.dataArray.removeAll()
        for dict in array {
            let addressEntity = JXAddressEntity()
            addressEntity.setValuesForKeys(dict)
            self.dataArray.append(addressEntity)
        }
        self.tableView?.reloadData()
    }
}

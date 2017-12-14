//
//  JXDBListViewController.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/8/16.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class JXDBListViewController: JXTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "FMDB"
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(edit(isEidt:index:)))
        let editItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editChanged))
        let dropItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dropTable))
        self.customNavigationItem.rightBarButtonItems = [addItem,editItem,dropItem]

        
        self.tableView?.frame = CGRect.init(x: 0, y: kNavStatusHeight, width: kScreenWidth, height: kScreenHeight - kNavStatusHeight)
        
        self.tableView?.register(UINib.init(nibName: "JXDBListCell", bundle: nil), forCellReuseIdentifier: cellId)
        self.tableView?.sectionFooterHeight = 0.1
        self.tableView?.tableFooterView = UIView()//group类型，设置高度不起作用
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView?.estimatedRowHeight = 44*kPercent
        
        //self.tableView?.isEditing = true
        self.tableView?.allowsMultipleSelectionDuringEditing =  true
        
        self.requestData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func dropTable() {
        if JXBaseDB.default.dropTable() == true {
            self.showNotice(notice: "删除表成功")
            requestData()
        }
    }
    @objc func editChanged() {
        guard var isEdit = self.tableView?.isEditing else {
            return
        }
        isEdit = !isEdit
        self.tableView?.setEditing(isEdit, animated: true)
    }
    @objc func edit(isEidt:Bool = false,index:Int) {
        let editVC = JXEditDBUserController()
        if isEidt {
            editVC.title = "修改数据"
            editVC.dbUserEntity = self.dataArray[index] as? DBUserModel
            editVC.editBlock = { entity in
                let range = Range(index..<(index + 1))
                self.dataArray.replaceSubrange(range, with: [entity])
                self.tableView?.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: .automatic)
            }
        }else{
            editVC.title = "插入数据"
            editVC.addBlock = { entity in
                self.dataArray.append(entity)
                self.tableView?.reloadData()
            }
        }
        
        self.navigationController?.pushViewController(editVC, animated: true)
    }
}

extension JXDBListViewController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! JXDBListCell
        
        let dbUserEntity = dataArray[indexPath.row] as! DBUserModel
        cell.model = dbUserEntity
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除！"
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {

        let style : UITableViewCellEditingStyle = .delete
        return style
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.dataArray.remove(at: indexPath.row)
//            self.dataArray.remove(at: indexPath.row)
//            self.tableView?.beginUpdates()
//            self.tableView.
//            self.tableView?.endUpdates()
        }
        
    }
    /// 代替以上的方法
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //default,destructive默认红色，normal默认灰色，可以通过backgroundColor 修改背景颜色，backgroundEffect 添加模糊效果
        let deleteAction = UITableViewRowAction(style: .destructive, title: "删除") { (action, indexPath) in
            print("删除")
            let model = self.dataArray[indexPath.row] as! DBUserModel
            if JXBaseDB.default.deleteData(condition: ["id = \(model.id)"]) == true{
                self.dataArray.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
        }
        let markAction = UITableViewRowAction(style: .default, title: "编辑") { (action, indexPath) in
            print("编辑")
            self.edit(isEidt: true, index: indexPath.row)
        }
        let checkAction = UITableViewRowAction(style: .normal, title: "查看") { (action, indexPath) in
            //
            print("查看")
        }
        markAction.backgroundColor = UIColor.orange
        return [deleteAction,markAction,checkAction]
    }
    
}
//MARK: - override super func
extension JXDBListViewController {
    
    override func requestData() {
        updateMainView()
    }
    override func updateMainView() {
        
        self.dataArray.removeAll()
        if let array = JXBaseDB.default.selectData(){
            print(array)
            for dict in array {
                if
                    let dict = dict as? Dictionary<String, Any>{
                    let model = DBUserModel()
                    model.setValuesForKeys(dict)
                    self.dataArray.append(model)
                }
            }
        }
        //let count = JXBaseDB.default.selectDataCount()
        let count = JXBaseDB.default.selectDataCount(key: "name", condition: ["id < \(3)"])
        self.title = "FMDB-\(count)"
        self.tableView?.reloadData()
    }
}

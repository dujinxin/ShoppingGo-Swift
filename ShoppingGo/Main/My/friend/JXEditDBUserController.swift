//
//  JXEditDBUserController.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/8/16.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class JXEditDBUserController: JXTableViewController {
    
    var dbUserEntity : DBUserModel?
    var placeholderArray = ["请输入姓名","请输入年龄","请选择性别","请输入分数"]
    
    var addBlock :((_ entity:DBUserModel)->())?
    var editBlock :((_ entity:DBUserModel)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customNavigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(save))
        
        self.tableView?.frame = CGRect.init(x: 0, y: kNavStatusHeight, width: kScreenWidth, height: kScreenHeight - kNavStatusHeight)
        
        self.tableView?.register(EditDBUserCell.self, forCellReuseIdentifier: cellId)
        self.tableView?.sectionFooterHeight = 0.1
        self.tableView?.tableFooterView = UIView()//group类型，设置高度不起作用
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView?.estimatedRowHeight = 44*kPercent
        
        self.refreshControl?.removeFromSuperview()
        
        
        
        self.requestData()

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func save() {
        var name : String?
        var age : String?
        var gender : String?
        var score : String?
        for i in 0..<4 {
            let indexPath = IndexPath(row: i, section: 0)
            
            let cell = tableView?.cellForRow(at: indexPath) as! EditDBUserCell
            
            if i == 0 {
                name = cell.textField.text
            }else if i == 1 {
                age = cell.textField.text
            }else if i == 2 {
                gender = cell.textField.text
            }else {
                score = cell.textField.text
            }
        }
        
        guard
            let name1 = name,
            name1.isEmpty == false else{
            self.showNotice(notice: "请输入姓名")
            return
        }
        
        guard
            let age1 = age,
            age1.isEmpty == false  else{
            self.showNotice(notice: "请输入年龄")
            return
        }
        
        guard
            let gender1 = gender,
            gender1.isEmpty == false  else{
            self.showNotice(notice: "请选择性别")
            return
        }
        
        guard
            let score1 = score,
            score1.isEmpty == false  else{
            self.showNotice(notice: "请输入分数")
            return
        }
        
        if
            let dbUserEntity = dbUserEntity,
            let editBlock = editBlock{
            dbUserEntity.name = name1
            dbUserEntity.age = Int(age1)!
            dbUserEntity.gender = Int(gender1)!
            dbUserEntity.score = Int(score1)!
            
            self.showLoadView()
            let dict = ["name":name1,"age":age1,"gender":gender1,"score":score1]
            if JXBaseDB.default.updateData(keyValues: dict, condition: ["id = \(dbUserEntity.id)"]) == true {
                self.showNotice(notice: "修改成功")
                editBlock(dbUserEntity)
                self.navigationController?.popViewController(animated: true)
            }else{
                self.hideLoadView()
            }
            
        }else{
            if let addBlock = addBlock {
                let dbUserEntity = DBUserModel()
                dbUserEntity.name = name1
                dbUserEntity.age = Int(age1)!
                dbUserEntity.gender = Int(gender1)!
                dbUserEntity.score = Int(score1)!
                self.showLoadView()
                let dict = ["name":name1,"age":age1,"gender":gender1,"score":score1]
                if self.insertData(data: dict) == true {
                    self.showNotice(notice: "添加成功")
                    addBlock(dbUserEntity)
                    self.navigationController?.popViewController(animated: true)
                }else{
                    self.showLoadView()
                }
            }
        }
    }
    func insertDatasClick() {
        if self.insertData() == true {
            self.showNotice(notice: "批量添加成功")
        }
    }
    func insertData(data:Dictionary<String,Any> = [:]) -> Bool {
        
        if data.isEmpty == false {
            let _ = JXBaseDB.default.createTable(keys: Array(data.keys))
            return JXBaseDB.default.insertData(data: data)
        }else{
            var datas = Array<Dictionary<String,Any>>()
            let nameArr = ["张三","李四","王五","赵六","胡二麻子"]
            
            self.showLoadView()
            
            for i in 0..<100 {
                let dict = [
                    "name":"\(nameArr[Int(arc4random_uniform(5))])\(i)",
                    "age":arc4random_uniform(10) + 10,
                    "gender":arc4random_uniform(2),
                    "score":arc4random_uniform(100) + 1] as [String : Any]
                datas.append(dict)
            }
            let _ = JXBaseDB.default.createTable(keys: Array(datas[0].keys))
            return JXBaseDB.default.insertDatas(datas: datas)
        }
    }
}

extension JXEditDBUserController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EditDBUserCell
        
        if indexPath.row == 2 {
            cell.textField.isEnabled = false
        }
        
        cell.placeHolderText = placeholderArray[indexPath.row]
        cell.textString = "\(self.dataArray[indexPath.row])"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 2 {
            let alertVC = UIAlertController(title: "请选择性别", message: nil, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "男", style: .destructive, handler: { (action) in
                let range = Range(2..<3)
                self.dataArray.replaceSubrange(range, with: [0])
                self.tableView?.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .automatic)
            }))
            alertVC.addAction(UIAlertAction(title: "女", style: .destructive, handler: { (action) in
                let range = Range(2..<3)
                self.dataArray.replaceSubrange(range, with: [1])
                self.tableView?.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .automatic)
            }))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}
//MARK: - override super func
extension JXEditDBUserController {
    
    override func requestData() {
        updateMainView()
    }
    override func updateMainView() {
        
        self.dataArray.removeAll()
        
        if let entity = dbUserEntity {
            self.dataArray.append(entity.name ?? "")
            self.dataArray.append(entity.age)
            self.dataArray.append(entity.gender)
            self.dataArray.append(entity.score)
            
        }else{
            for _ in 0..<4 {
                self.dataArray.append("")
            }
            
            let insertBUtton = UIButton()
            insertBUtton.backgroundColor = UIColor.originColor
            insertBUtton.setTitle("批量插入", for: .normal)
            insertBUtton.frame = CGRect(x: 0, y: kScreenHeight - kTabBarHeight, width: kScreenWidth, height: kTabBarHeight)
            insertBUtton.addTarget(self, action: #selector(insertDatasClick), for: .touchUpInside)
            view.addSubview(insertBUtton)
        }
        
        
        self.tableView?.reloadData()
    }
}

class EditDBUserCell: UITableViewCell,UITextFieldDelegate{
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.placeholder = ""
        tf.returnKeyType = .done
        tf.delegate = self
        return tf
    }()
    
    var textString: String? = "" {
        didSet{
            if let textString = textString,
                textString.isEmpty == false{
                self.textField.text = textString
            }
        }
    }
    var placeHolderText : String? {
        didSet{
            if let placeHolderText = placeHolderText,
                placeHolderText.isEmpty == false{
                textField.placeholder = placeHolderText
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.textField)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //self.textField.frame = bounds
        self.textField.frame = CGRect(x: 20, y: 0, width: bounds.width - 40, height: bounds.height)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

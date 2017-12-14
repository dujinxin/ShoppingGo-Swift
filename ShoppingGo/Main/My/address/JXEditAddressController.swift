//
//  JXEditAddressController.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/8/10.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class JXEditAddressController: JXTableViewController {
    
    var addressEntity : JXAddressEntity?
    var placeholderArray = ["请输入姓名","请输入手机号","请选择省市区","请输入详细地址"]
    var addressArray : NSMutableArray?
    
    var provinceArray = Array<String>()
    var cityArray = Array<String>()
    var areaArray = Array<String>()
    
    var addBlock :(()->())?
    var editBlock :((_ entity:JXAddressEntity)->())?
    
    lazy var pickSelectView: JXSelectView = {
        let select = JXSelectView(frame: CGRect(), style: .pick)
        select.isUseTopBar = true
        select.delegate = self
        select.dataSource = self
        return select
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customNavigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(save))
        
        self.tableView?.frame = CGRect.init(x: 0, y: kNavStatusHeight, width: kScreenWidth, height: kScreenHeight - kNavStatusHeight)
        
        self.tableView?.register(EditAddressCell.self, forCellReuseIdentifier: cellId)
        self.tableView?.sectionFooterHeight = 0.1
        self.tableView?.tableFooterView = UIView()//group类型，设置高度不起作用
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView?.estimatedRowHeight = 44*kPercent
        
        
        self.requestData()

        provinceArray = ["北京市","河北省"]
        
        cityArray = ["北京市"]
        areaArray = ["朝阳区","丰台区","海淀区"]
 
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func save() {
        var name : String?
        var phone : String?
        //var address : String?
        var addressDetail : String?
        for i in 0..<4 {
            let indexPath = IndexPath(row: i, section: 0)
            
            let cell = tableView?.cellForRow(at: indexPath) as! EditAddressCell
            
            if i == 0 {
                name = cell.textField.text
            }else if i == 1 {
                phone = cell.textField.text
            }else if i == 2 {
                //address = cell.textField.text
            }else {
                addressDetail = cell.textField.text
            }
        }

        guard let name1 = name else{
            self.showNotice(notice: "请输入姓名")
            return
        }

        guard let phone1 = phone else{
            self.showNotice(notice: "请输入手机号")
            return
        }

//        guard let address1 = address else{
//            self.showNotice(notice: "请输入姓名")
//            return
//        }

        guard let addressDetail1 = addressDetail else{
            self.showNotice(notice: "请输入详细地址")
            return
        }

        if
            let addressEntity = addressEntity,
            let editBlock = editBlock{
            addressEntity.name = name1
            addressEntity.phone = phone1
            addressEntity.address = addressDetail1
            
            editBlock(addressEntity)
            
        }else{
            if let addBlock = addBlock {
                addBlock()
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension JXEditAddressController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EditAddressCell
        
//        let addressEntity = dataArray[indexPath.row] as! JXAddressEntity
//        cell.model = addressEntity
        
        if indexPath.row == 2 {
            cell.textField.isEnabled = false
        }
        
        cell.placeHolderText = placeholderArray[indexPath.row]
    
        if let _ = addressEntity {
            cell.textString = self.dataArray[indexPath.row] as? String
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 2 {
            print("三级联动地址选择器")
            self.pickSelectView.show()
        }
    }
}
extension JXEditAddressController : JXSelectViewDelegate,JXSelectViewDataSource{
    func jxSelectView(_: JXSelectView, didSelectRowAt row: Int, inSection section: Int) {
        if section == 0 {
            if row == 0 {
                cityArray = ["北京市"]
            }else{
                cityArray = ["石家庄市","张家口市"]
            }
        }else if section == 1{
            if row == 0 {
                if cityArray.count == 1 {
                    areaArray = ["朝阳区","丰台区","海淀区"]
                }else{
                    areaArray = ["无极限","赵县","辛集"]
                }
            }else{
                areaArray = ["张北县","宣化县","蔚县"]
            }
        }
    }

    func jxSelectView(_: JXSelectView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return provinceArray.count
        }else if section == 1{
            return cityArray.count
        }else{
            return areaArray.count
        }
    }
    func jxSelectView(_: JXSelectView, contentForRow row: Int, InSection section: Int) -> String {
        if section == 0 {
            return provinceArray[row]
        }else if section == 1{
            return cityArray[row]
        }else{
            return areaArray[row]
        }
    }
    func jxSelectView(_: JXSelectView, heightForRowAt row: Int) -> CGFloat {
        return 40
    }
    func jxSelectView(_: JXSelectView, widthForComponent component: Int) -> CGFloat {
        return kScreenWidth / 3
    }
    func numberOfComponents(_: JXSelectView) -> Int {
        return 3
    }
}
//MARK: - override super func
extension JXEditAddressController {
    
    override func requestData() {
        updateMainView()
    }
    override func updateMainView() {
        
        self.dataArray.removeAll()
        if let entity = addressEntity {
            self.dataArray.append(entity.name ?? "")
            self.dataArray.append(entity.phone ?? "")
            self.dataArray.append("")
            self.dataArray.append(entity.address ?? "")
        }
        
        
        self.tableView?.reloadData()
    }
}

class EditAddressCell: UITableViewCell,UITextFieldDelegate{
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

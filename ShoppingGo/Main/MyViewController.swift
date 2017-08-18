//
//  MyViewController.swift
//  ShoppingGo-Swift
//
//  Created by 杜进新 on 2017/6/6.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit
import Social

private let cellId = "cellId"
private let MyHeadViewHeight : CGFloat = 225
private let MyHeadItemHeight : CGFloat = kScreenWidth / 4


class MyViewController: JXTableViewController {
    
    lazy var headView: UIView = {
        let v = UIView()
        return v
    }()
    
    lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "bg")
        return imageView
    }()
    
    lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "portrait_storke")
        
        return imageView
    }()
    lazy var nameLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.white
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textAlignment = .center
        return lab
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.style = .grouped
        self.tableView?.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 49)
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.tableView?.contentInset = UIEdgeInsetsMake(MyHeadViewHeight + MyHeadItemHeight, 0, 0, 0)
        self.tableView?.sectionHeaderHeight = 10 //group类型，第一分区不起做用，需要通过代理方法设置
        self.tableView?.sectionFooterHeight = 0.1
        self.tableView?.tableFooterView = UIView()//group类型，设置高度不起作用
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView?.estimatedRowHeight = 44*kPercent
        
        self.customNavigationBar.barTintColor = UIColor.orange
        self.customNavigationBar.alpha = 0
        self.customNavigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "登录", style: UIBarButtonItemStyle.plain, target: self, action: #selector(login))
        
        self.customNavigationItem.rightBarButtonItem = UIBarButtonItem.init(imageName: "title_icon_notice", target: self, action: #selector(nextPage))
        
        
        setHeadView()
        
        requestData()


        if UserManager.default.isLogin {
//            self.userImageView.setImageWith(URL.init(string: UserManager.default.userModel.UserImage!)!, placeholderImage: UIImage(named: "portrait_storke"))
            self.userImageView.jx_setImage(with: UserManager.default.userModel.UserImage!, placeholderImage: UIImage(named: "portrait_default"), radius: 68*kPercent/2)
            self.nameLabel.text = UserManager.default.userModel.UserName
        }else{
            //self.userImageView.image = UIImage(named: "portrait_default")
            self.userImageView.image = UIImage.image(originalImage: UIImage(named: "portrait_default"), rect: CGRect.init(x: 0, y: 0, width: 68*kPercent/2, height: 68*kPercent/2), radius: 68*kPercent/2)
            self.nameLabel.text = "登录"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    func login() {
        present(JXLoginViewController(), animated: true, completion: nil)
    }
    func userInfo() {
        self.navigationController?.pushViewController(JXUserInfoViewController(), animated: true)
    }
    @objc private func nextPage() {
  
    }
    func buttonAction(button:UIButton) {
        print(button.tag)
        let v = JXDrawViewController()
        v.title = "绘图"
        navigationController?.pushViewController(v, animated: true)
    }

}
extension MyViewController {
    
    func setHeadView() {
        
        self.tableView?.addSubview(self.headView)
        self.headView.addSubview(self.bgImageView)
        self.headView.addSubview(self.userImageView)
        self.headView.addSubview(self.nameLabel)
        
        self.headView.frame = CGRect(x: 0, y: -MyHeadViewHeight - MyHeadItemHeight, width: kScreenWidth, height: MyHeadViewHeight + MyHeadItemHeight)
        self.bgImageView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: MyHeadViewHeight)
        self.userImageView.frame = CGRect(x: (kScreenWidth-68*kPercent)/2, y: 64, width: 68*kPercent, height: 68*kPercent)
//        self.userImageView.layer.cornerRadius = 65*kPercent/2
//        self.userImageView.layer.masksToBounds = true
//        self.userImageView.layer.borderColor = UIColor.white.cgColor
//        self.userImageView.layer.borderWidth = 3
        
        self.userImageView.isUserInteractionEnabled = true
        self.userImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userInfo)))
        self.nameLabel.frame = CGRect(x: 0, y: self.userImageView.frame.maxY + 8, width: kScreenWidth, height: 14)
        
        

        let titleArray = ["Coupon","Follow","Chat","Order"]
        let imageArray = ["icon_coupons","icon_follower","icon_chat","icon_consumption"]
        
        for i in 0..<titleArray.count {
            let btn = UIButton()
            btn.backgroundColor = JXFfffffColor
            btn.setTitle(titleArray[i], for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitleColor(JX333333Color, for: .normal)
            btn.setBackgroundImage(UIImage(named: "icon_normal"), for: .normal)
            btn.setBackgroundImage(UIImage(named: "icon_pressed"), for: .highlighted)
            btn.contentVerticalAlignment = .bottom
            btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 18*kPercent, 0)
            btn.tag = i
            btn.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
            
            let imageView = UIImageView()
            imageView.isUserInteractionEnabled = false
            imageView.image = UIImage(named: "portrait_storke")
            imageView.image = UIImage(named: imageArray[i])
            
            let xLine = UIView()
            xLine.backgroundColor = JXEeeeeeColor
            
            let yLine = UIView()
            yLine.backgroundColor = JXEeeeeeColor
            
            btn.addSubview(imageView)
            btn.addSubview(yLine)
            if i < titleArray.count - 1 {
                btn.addSubview(xLine)
            }
            headView.addSubview(btn)
            
            btn.frame = CGRect(x: kScreenWidth / 4 * CGFloat(i), y: MyHeadViewHeight, width: MyHeadItemHeight, height: MyHeadItemHeight)
            imageView.frame = CGRect(x: (kScreenWidth / 4 - 25*kPercent)/2, y: 18*kPercent, width: 25*kPercent, height: 25*kPercent)
            xLine.frame = CGRect(x:0, y:0, width:kScreenWidth / 4 - 0.5, height:0.5)
            yLine.frame = CGRect(x:kScreenWidth / 4 - 0.5, y:0, width:0.5, height:MyHeadItemHeight)
        }

    }
    
    func setNavigationBar(){
    
    }
}
extension MyViewController {
    
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
            if indexPath.row == 0 {
                print(DBManager.default.selectData(name: "DBManager"))
            }else if indexPath.row == 1 {
                print(DBManager.default.selectData(name: "DBManager", keys: ["UserName","UserImage"]))
            }else{
                print(DBManager.default.selectData(name: "DBManager", keys: ["UserName","UserImage"],condition: ["id= \(3)"]))
            }
        }else if indexPath.section == 1{
            if indexPath.row == 0 {
                print(DBManager.default.selectData(name: "DBManager", keys: [],condition: ["id = \(1)"]))
            }else{
                print(DBManager.default.updateData(name: "DBManager", keyValues: ["UserName":"ABC"], condition: ["id = \(1)"]))
            }
            
            
        }else if indexPath.section == 2 {
            self.navigationController?.pushViewController(JXSettingViewController(), animated: true)
        } else {
            
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        let xOffset = (yOffset + MyHeadViewHeight + MyHeadItemHeight )/2
        if yOffset < -(MyHeadItemHeight + MyHeadViewHeight) {
            var rect = self.bgImageView.frame
            rect.origin.y = yOffset
            rect.size.height = CGFloat(fabs(yOffset)) + MyHeadViewHeight
            rect.origin.x = xOffset
            rect.size.width = kScreenWidth + CGFloat(fabs(xOffset))
            self.bgImageView.frame = rect
        }else{
            
        }
        if yOffset >= kNavStatusHeight - (MyHeadViewHeight + MyHeadItemHeight) {
            //self.customNavigationBar.barTintColor = UIColor.orange
            self.customNavigationBar.alpha = 1
        }else if yOffset <= -(MyHeadItemHeight + MyHeadViewHeight){
            self.customNavigationBar.alpha = 0
        }else{
            self.customNavigationBar.alpha = fabs(fabs(yOffset) - (MyHeadViewHeight + MyHeadItemHeight)) / kNavStatusHeight
        }
        
    }
}
//MARK: - override super func
extension MyViewController {
    
    
    override func setUpDefaultView() {
        self.userImageView.image = UIImage(named: "portrait_storke")
        self.nameLabel.text = "登录"
    }
    override func requestData() {
        
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 4) {
            
            self.refreshControl?.endRefreshing()
        }
        updateMainView()
    }
    override func updateMainView() {
        self.dataArray.removeAll()
        self.dataArray = [
            [
                //{"title":"Coupons","image":"list_icon_privilege"},
                ["title":"Records","image":"list_icon_record"],
                ["title":"Favorites","image":"list_icon_collect"],
                ["title":"Level","image":"list_icon_level"]
            ],
            [
                ["title":"Follower","image":"list_icon_fans"],
                ["title":"Share","image":"list_icon_friends_share"]
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

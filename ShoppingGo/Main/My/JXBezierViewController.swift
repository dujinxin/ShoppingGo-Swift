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
    override func tableView(_ tvareView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        if
            let dict = dataArray[indexPath.row] as? Dictionary<String,Any>,
            let title = dict["title"] as? String,
            let image = dict["image"] as? UIImage
        {
            //cell.textLabel?.text = LanguageManager.manager.localizedString(title)
            cell.textLabel?.text = LanguageManager.localizedString(title)
            cell.imageView?.image = image
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var v : UIView?
        
        switch indexPath.row {
        case 0:
            v = JXBezierSingleLineView()
        case 1:
            v = JXBezierPolygonView()
        case 2:
            v = JXBezierRectangleView()
        case 3:
            v = JXBezierCircleEllipseView()
        case 4:
            v = JXBezierCircleAngleView()
        case 5:
            v = JXBezierRoundRectView()
        case 6:
            v = JXBezierRoundRectCustomView()
        case 7:
            v = JXBezierTwiceBezierCurveView()
        case 8:
            v = JXBezierThreeBezierCurveView()
        case 9:
            v = JXTestView()
        default:
            break
        }
        
        v?.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth / 2)
        v?.backgroundColor = UIColor.clear
        v?.alpha = 0.25
        let select = JXSelectView(frame: CGRect(), customView: v!)

        //let alert = JXAlertView(frame: CGRect.init(x: 0, y: 0, width: 300, height: 300), style: .custom)
        select.position = .middle
        select.show()
        
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
        
        
        let titleArray = ["单线","多边形","矩形","圆形&椭圆","圆形&扇形&圆弧","圆角矩形","圆角矩形&自由指定圆角位置","二次贝塞尔曲线","三次贝塞尔曲线","测试"]
        let imageArray = [JXBezierSingleLineView(),JXBezierPolygonView(),JXBezierRectangleView(),JXBezierCircleEllipseView(),JXBezierCircleAngleView(),JXBezierRoundRectView(),JXBezierRoundRectCustomView(),JXBezierTwiceBezierCurveView(),JXBezierThreeBezierCurveView(),JXTestView()]
        
        
        for i in 0..<titleArray.count {
            var dict = Dictionary<String,Any>()
            dict["title"] = titleArray[i]
            let v = imageArray[i]
            v.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            v.backgroundColor = UIColor.white
            
            dict["image"] = UIImage.imageScreenshot(view: v)
            self.dataArray.append(dict)
        }
//        self.dataArray = [
//                //{"title":"Coupons","image":"list_icon_privilege"},
//                ["title":"单线","image":"list_icon_record"],
//                ["title":"多边形","image":"list_icon_collect"],
//                ["title":"矩形","image":"list_icon_level"],
//                ["title":"圆形","image":"list_icon_fans"],
//                ["title":"椭圆","image":"list_icon_friends_share"],
//                ["title":"Settings","image":"list_icon_setting"],
//                ["title":"Help","image":"list_icon_help"],
//                ["title":"OpenShop","image":"list_icon_open_shop"],
//                ["title":"Invitation","image":"list_icon_invitation"],
//                ["title":"Service","image":"list_icon_phon"]
//        ]
        self.tableView?.reloadData()
    }
}

//
//  TodayViewController.swift
//  Widget
//
//  Created by 杜进新 on 2017/12/11.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit
import NotificationCenter

import SDWebImage

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        button.setTitle("测试", for: .normal)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        button.center = CGPoint(x: self.view.center.x, y: 200)
        
        button.setTitle(GroupUserManager.default.userModel.UserName, for: .normal)
        button.sd_setImage(with: URL(string: GroupUserManager.default.userModel.UserImage!), for: .normal)
        button.contentMode = .scaleAspectFill
        
        self.textLabel.text = GroupUserManager.default.msg
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        switch sender.selectedSegmentIndex {
        case 0:
            let url = URL(string: String(format: "Widget://%@", "my"))
            self.extensionContext?.open(url!, completionHandler: { (isSuccess) in
                print("open success")
            })
        case 1:
            let url = URL(string: String(format: "Widget://%@", "myInfo"))
            self.extensionContext?.open(url!, completionHandler: { (isSuccess) in
                print("open success")
            })
        case 2:
            let url = URL(string: String(format: "Widget://%@", "address"))
            self.extensionContext?.open(url!, completionHandler: { (isSuccess) in
                print("open success")
            })
        default:
            let url = URL(string: String(format: "Widget://%@", GroupUserManager.default.userModel.PhoneNumber ?? "123456"))
            self.extensionContext?.open(url!, completionHandler: { (isSuccess) in
                print("open success")
            })
        }
        
    }
    @objc func buttonClick(_ sender: Any) {
        let url = URL(string: String(format: "Widget://%@", "notice"))
        self.extensionContext?.open(url!, completionHandler: { (isSuccess) in
            print("open success")
        })
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    /// 根据不同的模式设置组件的高度，宽度不起作用（默认）
    ///
    /// - Parameters:
    ///   - activeDisplayMode: 展示模式
    ///   - maxSize: 最大尺寸
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
        if activeDisplayMode == .compact {
            self.preferredContentSize = CGSize.init(width: maxSize.width, height: 200)
        }else{
            self.preferredContentSize = CGSize.init(width: maxSize.width, height: 400)
        }
    }
    
}

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
        
        if #available(iOSApplicationExtension 10.0, *) {
            self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        } else {
            // Fallback on earlier versions
        }
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        button.setTitle("测试", for: .normal)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        button.center = CGPoint(x: self.view.center.x, y: 200)
        
        button.setTitle(GroupUserManager.default.userModel.UserName, for: .normal)
        button.sd_setImage(with: URL(string: GroupUserManager.default.userModel.UserImage!), for: .normal)
        button.contentMode = .scaleAspectFill



        let dict = GroupUserManager.default.getUser(fromUserDefaults: "")
        print(dict ?? "")

        self.textLabel.text = "\(String(describing: GroupUserManager.default.userModel.UserName)):\(String(describing: dict!["PhoneNumber"]))"
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
    @available(iOSApplicationExtension 10.0, *)
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
        if activeDisplayMode == .compact {
            self.preferredContentSize = CGSize.init(width: maxSize.width, height: 200)
        }else{
            self.preferredContentSize = CGSize.init(width: maxSize.width, height: 400)
        }
    }
    
}







/*
应用领域

个人助理（智能手机上的语音助理、语音输入、家庭管家和陪护机器人） 产品举例：微软小冰、百度度秘、科大讯飞等、Amazon Echo、Google Home等
安防（智能监控、安保机器人） 产品举例：商汤科技、格灵深瞳、神州云海
自驾领域（智能汽车、公共交通、快递用车、工业应用） 产品举例：Google、Uber、特斯拉、亚马逊、奔驰、京东等
医疗健康（医疗健康的监测诊断、智能医疗设备） 产品举例： Enlitic、Intuitive Sirgical、碳云智能、Promontory等
电商零售（仓储物流、智能导购和客服） 产品举例：阿里、京东、亚马逊
金融（智能投顾、智能客服、安防监控、金融监管） 产品举例：蚂蚁金服、交通银行、大华股份、kensho
教育（智能评测、个性化辅导、儿童陪伴） 产品举例：学吧课堂、科大讯飞、云知声

专利

机器人，语音识别，神经网络，机器学习，图像识别，计算机视觉

成功案例

苹果Siri-声控智能助手，运用机器学习技术
alexa[ə'leksə]() - 智能家居中心
Tesla(特斯拉) - 预测能力，无人驾驶，高端的技术“冷却”,无线信息更新
Cogito- Cogito是一家人工智能公司，公司结合行为科学和人工智能技术实时检测消费者的情绪状态，并确定他们的心情是否已经改变以及对话的内容应该如何进行。通过使用Cogito的服务，一些公司的消费者满意度能够上升超过20%，一些代理公司的参与度能上升超过50%
Boxever-利用机器学习提高旅游产业的用户体验
John Paul 高端豪华旅游礼宾公司，利用预测算法来维护和客户之间的关系
Amazon 亚马逊 预测客户线上购物购物喜好，行为等
Neflix- 观影，预测对视频的喜好
Pandora 音乐DNA 预测对音乐的偏好
Nest 运用算法学习你的加热冷却温度喜好，来预测和自动调节家里和办公室的室温

*/







//
//  JXTabBarController.swift
//  ShoppingGo-Swift
//
//  Created by 杜进新 on 2017/6/6.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class JXTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.red
        
        setJXViewControllers()
        
        if JXGuideView.isShowGuideView{
            setGuideView()
        }else{
            setAdvertiseView()
        }

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension JXTabBarController {
    
    /// set tabBarController viewControllers
    func setJXViewControllers(){
        
        let infoArray = [
            ["className":"HomeViewController",
             "title":"首页",
             "imageName":"home",
             "defaultInfo":["imageName":"location_address_none",
                            "content":"生活还很艺术，酷爱艺术而活下去的人，到了晚年就不会太凄凉。"
                ]
            ],
            ["className":"BusinessViewController","title":"商圈","imageName":"businesscircle","defaultInfo":["imageName":"order_none", "content":"为了寻你，我错过了许许许多多的良辰美景，错过了闲看花开花落的心情，可我不后悔，因为你是我今生最美的遇见，寻得你，我就拥有了全世界的花开颜色。你的到来，为我拂去了浪迹天涯的孤独，我漂泊的灵魂再也不用辗转流连于亭台..."]],
            ["className":"FindViewController","title":"发现","imageName":"find","defaultInfo":["imageName":"order_none", "content":"曾经以为，这样的一见如故，会是我今生最美丽的相遇;曾经以为，这样的一诺相许，会是我素色年华里最永恒的风景;曾经以为，这样的心心相印，会是我无怨无悔的追逐。却不知，繁华有时，落寞有时，却怎么也读不懂我心头的一丝缠绵..."]],
            ["className":"MyViewController","title":"我的","imageName":"my","defaultInfo":["imageName":"collection_none", "content":"好久不见，凝望着你那优美的锁骨，追随着你那圆润的弧线，抚摸着你冰冷的肌肤，我就无法抑制内心的冲动，给开锁公司打电话的冲动，因为我忘带钥匙了!"]]
        ]
        
        var controllers = [UIViewController]()
        
        for dict in infoArray {
            controllers.append(setViewcontroller(info: dict as [String : AnyObject]))
        }
    
        self.viewControllers = controllers
    }
    
    /// set single ViewController vith title , image
    ///
    /// - Parameter info: type:[key:value] className,title,imageName
    /// - Returns: viewController
    func setViewcontroller(info:[String:AnyObject]) -> UIViewController {
        guard let bundleName = Bundle.main.infoDictionary?["CFBundleName"] as? String,
              let vcName = info["className"],
              let Class = NSClassFromString(bundleName + "." + (vcName as! String)) as? BaseViewController.Type
            
            else {
            return UIViewController()
        }
        
        let vc = Class.init()
        
        vc.title = info["title"] as? String
        vc.tabBarItem.image = UIImage.init(named: ((info["imageName"]! as! String) + "_default"))
        
        vc.defaultInfo = info["defaultInfo"] as? [String : String]
        
        let nvc = JXNavigationController(rootViewController: vc)
    
        return nvc
        
    }
    
}

extension JXTabBarController {
    
    func setGuideView() {

        let guideView = JXGuideView(frame: view.bounds) { (guide) in
            guide.removeFromSuperview()
        }
        view.addSubview(guideView)
        
        //1.获取token,首次安装用本地生成的字符串来获取token
        //2.本地有保存token,则用长token去刷新token
        if
            let _ = UserManager.default.userModel.Token,
            let longToken = UserManager.default.userModel.RefreshToken{
            
            JXRequest.request(url: ApiString.refreshToken.rawValue, param: ["RToken":longToken], success: { (data, msg) in
                //
                print(data)
            }, failure: { (msg, code) in
                //
                print(msg)
            })
            
        }else{
            JXRequest.request(url: ApiString.getTokenByKey.rawValue, param: ["Uc":(UIDevice.current.identifierForVendor?.uuidString)!], success: { (data, msg) in
                
                guard let data = data as? Dictionary<String, Any> else{
                    return
                }
                let isSuccess = UserManager.default.saveUserInfo(dict: data)
                print("保存token：\(isSuccess)")
                
            }, failure: { (msg, errorCode) in
                print(msg)
            })
        }
    }
    func setAdvertiseView() {
        let adView = JXAdvertiseView(frame: view.bounds)
        view.addSubview(adView)
        
        /**
         * 服务器有问题，游客token不允许刷新，就直接为失效。导致的问题为：游客身份token刷新接口不可用，
         */
        //不是首次使用，本地有保存token,所以直接用长token去刷新token即可
        if
            let _ = UserManager.default.userModel.Token,
            let longToken = UserManager.default.userModel.RefreshToken{
            
            JXRequest.request(url: ApiString.refreshToken.rawValue, param: ["RToken":longToken], success: { (data, msg) in
                print(data)
                guard let data = data as? Dictionary<String, Any> else{
                    return
                }
                let isSuccess = UserManager.default.saveUserInfo(dict: data)
                print("保存token：\(isSuccess)")
            }, failure: { (msg, code) in
                print(msg)
            })
        }

    }
}

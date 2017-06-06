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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension JXTabBarController {
    
    func setJXViewControllers(){
        
        let infoArray = [
            ["className":"HomeViewController","title":"首页","imageName":"home"],
            ["className":"BusinessViewController","title":"商圈","imageName":"businesscircle"],
            ["className":"FindViewController","title":"发现","imageName":"find"],
            ["className":"MyViewController","title":"我的","imageName":"my"]
        ]
        
        var controllers = [UIViewController]()
        
        
        for dict in infoArray {
            
            controllers.append(setViewcontroller(info: dict))
        }
    
        self.viewControllers = controllers
    }
    
    func setViewcontroller(info:[String:String]) -> UIViewController {
        let className = (Bundle.main.infoDictionary?["CFBundleName"] as? String )! + "." + info["className"]!
        //let className = "ShoppingGo" + "." + info["className"]!
        
        let Class = NSClassFromString(className) as? UIViewController.Type
        
        let vc = Class?.init()
        
        vc?.title = info["title"]
        vc?.tabBarItem.image = UIImage.init(named: (info["imageName"]! + "_default"))
        
        let nvc = JXNavigationController(rootViewController: vc!)
    
        return nvc
        
        
    }
    
}

//
//  JXNavigationController.swift
//  ShoppingGo-Swift
//
//  Created by 杜进新 on 2017/6/6.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class JXNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar.isTranslucent = true
        self.navigationBar.barStyle = .blackTranslucent
        self.navigationBar.barTintColor = UIColor.orange//导航条颜色
        self.navigationBar.tintColor = UIColor.white   //item图片文字颜色
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.black,NSFontAttributeName:UIFont.systemFont(ofSize: 22)]//标题设置
        
        self.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension JXNavigationController {
    
    /// 重写push方法
    ///
    /// - Parameters:
    ///   - viewController: 将要push的viewController
    ///   - animated: 是否使用动画
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
      
        
        if  let vc = viewController as? JXBaseViewController{
            if viewControllers.count > 0 {
                vc.hidesBottomBarWhenPushed = true
                
                var titleName = "返回"
                
                if viewControllers.count == 1 {
                    titleName = viewControllers.first?.title ?? titleName
                }
                //vc.customNavigationItem.leftBarButtonItem = UIBarButtonItem(title: titleName, style: .plain, target: self, action: #selector(pop))
                vc.customNavigationItem.leftBarButtonItem = UIBarButtonItem(title: titleName, imageName: "back", target: self, action: #selector(pop))
            }
        }
        super.pushViewController(viewController, animated: true)
    }
    
    /// 自定义导航栏的返回按钮事件
    func pop() {
        popViewController(animated: true)
    }
}

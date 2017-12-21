//
//  AppDelegate.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/6/6.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        if #available(iOS 9.1, *) {
            //set 3D-Touch,最多可以设置四个
            let icon1 = UIApplicationShortcutIcon.init(type: .add)
            let item1 = UIApplicationShortcutItem.init(type: "new", localizedTitle: "新增", localizedSubtitle: nil, icon: icon1, userInfo: ["type":1,"msg":"这是一个测试信息","title":"测试"])
            
            let icon2 = UIApplicationShortcutIcon.init(type: .home)
            let item2 = UIApplicationShortcutItem.init(type: "home", localizedTitle: "主页", localizedSubtitle: nil, icon: icon2, userInfo: nil)
            
            let icon3 = UIApplicationShortcutIcon.init(type: .contact)
            let item3 = UIApplicationShortcutItem.init(type: "my", localizedTitle: "我的", localizedSubtitle: nil, icon: icon3, userInfo: nil)
            
            let icon4 = UIApplicationShortcutIcon.init(templateImageName: "address_edit")
            let item4 = UIApplicationShortcutItem.init(type: "address", localizedTitle: "地址", localizedSubtitle: "编辑收货地址", icon: icon4, userInfo: nil)
            
            application.shortcutItems = [item1,item2,item3,item4]
            
        } else {
            
        }
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        
        let vc = JXTabBarController()
        vc.delegate = self
        
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url)
        if app.canOpenURL(url) {
            if let host = url.host,url.scheme == "Widget"{
                self.schemePerform(type: host)
            }
        }
        return true
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        print(url)
        if application.canOpenURL(url) {
            if let host = url.host,url.scheme == "Widget"{
                self.schemePerform(type: host)
            }
        }
        return true
    }
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print(shortcutItem.type)
        
        self.schemePerform(type: shortcutItem.type, userInfo: shortcutItem.userInfo)
    }
    func schemePerform(type:String,userInfo:Dictionary<String,NSSecureCoding>? = nil) {
        
        if type == "home" {
            
        }else if type == "my" {
            let tabVC = self.window?.rootViewController as! JXTabBarController
            tabVC.selectedIndex = 3
        }else if type == "order" {
            let infoVC = JXOrderManageController()
            JXViewManager.manager.pushViewController(infoVC)
        }else if type == "address" {
            let infoVC = JXAddressListController()
            JXViewManager.manager.pushViewController(infoVC)
        }else if type == "myInfo"{
            let infoVC = JXUserInfoViewController()
            JXViewManager.manager.presentViewController(infoVC)
        }else if type == "notice"{
            JXViewManager.manager.showJXNoticeView(notice: "Widget message")
        }else if type == "new"{
            if let dict = userInfo , dict.isEmpty == false{
                print(dict)
            }
        }else{
            print("未定义host:\(String(describing: type))")
        }
    }
}
extension AppDelegate:UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}


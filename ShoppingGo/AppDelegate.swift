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
            if (url.scheme == "Widget") {
                if url.host == "my" {
                    let tabVC = self.window?.rootViewController as! JXTabBarController
                    tabVC.selectedIndex = 3
                }else if url.host == "order" {
                    let infoVC = JXOrderManageController()
                    JXViewManager.manager.pushViewController(infoVC)
                }else if url.host == "address" {
                    let infoVC = JXAddressListController()
                    JXViewManager.manager.pushViewController(infoVC)
                }else if url.host == "myInfo"{
                    let infoVC = JXUserInfoViewController()
                    JXViewManager.manager.presentViewController(infoVC)
                }else if url.host == "notice"{
                    JXViewManager.manager.showJXNoticeView(notice: "Widget message")
                }else{
                    print("未定义host:\(String(describing: url.host))")
                }
            }
        }
        return true
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        print(url)
        if application.canOpenURL(url) {
            if (url.scheme == "Widget") {
                if url.host == "my" {
                    let tabVC = self.window?.rootViewController as! JXTabBarController
                    tabVC.selectedIndex = 3
                }else if url.host == "order" {
                    let infoVC = JXOrderManageController()
                    JXViewManager.manager.pushViewController(infoVC)
                }else if url.host == "address" {
                    let infoVC = JXAddressListController()
                    JXViewManager.manager.pushViewController(infoVC)
                }else if url.host == "myInfo"{
                    let infoVC = JXUserInfoViewController()
                    JXViewManager.manager.presentViewController(infoVC)
                }else if url.host == "notice"{
                    JXViewManager.manager.showJXNoticeView(notice: "Widget message")
                }else{
                    print("未定义host:\(String(describing: url.host))")
                }
            }
        }
        return true
    }

}
extension AppDelegate:UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}


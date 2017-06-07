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
        
        self.navigationBar.barTintColor = UIColor.orange//导航条颜色
        self.navigationBar.tintColor = UIColor.yellow   //item图片文字颜色
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.red,NSFontAttributeName:UIFont.systemFont(ofSize: 25)]//标题设置
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

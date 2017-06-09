//
//  BusinessViewController.swift
//  ShoppingGo-Swift
//
//  Created by 杜进新 on 2017/6/6.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class BusinessViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.orange//导航条颜色
        navigationController?.navigationBar.tintColor = UIColor.red   //item图片文字颜色
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blue,NSFontAttributeName:UIFont.systemFont(ofSize: 22)]//标题设置
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "title_icon_notice"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(nextPage))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "title_icon_notice", target: self, action: #selector(nextPage))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func nextPage() {
        let v = ViewController()
        navigationController?.pushViewController(v, animated: true)
        
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

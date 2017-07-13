//
//  FindViewController.swift
//  ShoppingGo-Swift
//
//  Created by 杜进新 on 2017/6/6.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class FindViewController: JXWkWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpMainView()
        
        if let url = URL(string: "https://www.baidu.com") {
            self.webView.load(URLRequest(url: url))
        }
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

extension FindViewController {
    override func setUpMainView() {
        super.setUpMainView()
    }
    override func setUpDefaultView() {
//        super.setUpDefaultView()
//        self.defaultView.style = .noNetwork
    }
    override func requestData() {
        print("重新请求")
    }
}

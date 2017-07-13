//
//  JXUIWebViewController.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/7/13.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class JXUIWebViewController: BaseViewController {
    
    lazy var webView: UIWebView = {
        let web = UIWebView()
        web.delegate = self
        return web
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpMainView()
        
//        if let url = URL(string: "https://www.baidu.com") {
//            self.webView.loadRequest(URLRequest(url: url))
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setUpMainView() {
        self.webView.frame = view.bounds
        view.addSubview(self.webView)
    }

}



extension JXUIWebViewController:UIWebViewDelegate{
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("start")
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("finish")
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("fail:\(error.localizedDescription)")
    }
}

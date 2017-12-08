//
//  FindViewController.swift
//  ShoppingGo-Swift
//
//  Created by 杜进新 on 2017/6/6.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit
import WebKit
let kDiscoveryUrl = "https://find.guangjiego.com/Discovery/home.html"  //发现

//"https://www.baidu.com"

class FindViewController: JXWkWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpMainView()
        
        let oldAgent = UIWebView().stringByEvaluatingJavaScript(from: "navigator.userAgent")
        let newAgent = oldAgent?.appendingFormat("%@guangjiego/%@", oldAgent!,"2.1.7")
        let dict = ["UserAgent":newAgent!] as [String:Any]
        
        UserDefaults.standard.register(defaults: dict)
        UserDefaults.standard.synchronize()
   
        self.webView.evaluateJavaScript("navigator.userAgent") { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                print(data)
            }
        }
    
        self.webView.configuration.userContentController.add(self, name: "getParames")
        
        //[self.bridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];
        
        if let url = URL(string: kDiscoveryUrl) {
            self.webView.load(URLRequest(url: url))
        }
        self.webView.evaluateJavaScript("testJavascriptHandler") { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                print(data)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        self.webView.configuration.userContentController.removeScriptMessageHandler(forName: "getParames")
    }
    func getParames(param:Dictionary<String,Any>,callBack:((_ paramStr:String)->())?) {
        print("1234567890")
        callBack!("1234567890")
    }
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
extension FindViewController {
    override func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //
    }
    override func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //
    }
    override func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        //
    }
    override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    override func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("message:",message)
    }
}

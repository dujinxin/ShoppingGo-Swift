//
//  JXWkWebViewController.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/7/13.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit
import WebKit

class JXWkWebViewController: JXBaseViewController {

    lazy var webView: WKWebView = {
        let web = WKWebView()
        
        //web.uiDelegate = self
        web.navigationDelegate = self
        return web
    }()
    lazy var processView: UIProgressView = {
        let process = UIProgressView()
        process.progressTintColor = UIColor.blue
        process.progress = 0.0
        return process
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

//        if let url = URL(string: "https://www.baidu.com") {
//            self.webView.load(URLRequest(url: url))
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setUpMainView() {
        self.webView.frame = view.bounds
        view.addSubview(self.webView)
        
        self.processView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 5)
        view.addSubview(self.processView)
        
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        if
            let change = change,
            let processValue = change[NSKeyValueChangeKey.newKey],
            keyPath == "estimatedProgress",
            let process = processValue as? Float{
            
            self.processView.setProgress(process, animated: true)//动画有延时，所以要等动画结束再隐藏
            if process == 1.0 {
                //perform(<#T##aSelector: Selector##Selector#>, with: <#T##Any?#>, afterDelay: <#T##TimeInterval#>)
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.25, execute: {
                    self.processView.alpha = 0.0
                })
            }
        }
    }
    deinit {
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
}

extension JXWkWebViewController:WKUIDelegate{
    /*! @abstract Creates a new web view.
     @param webView The web view invoking the delegate method.
     @param configuration The configuration to use when creating the new web
     view.
     @param navigationAction The navigation action causing the new web view to
     be created.
     @param windowFeatures Window features requested by the webpage.
     @result A new web view or nil.
     @discussion The web view returned must be created with the specified configuration. WebKit will load the request in the returned web view.
     
     If you do not implement this method, the web view will cancel the navigation.
     */
//    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//        return self.wkWebView
//    }
    func webViewDidClose(_ webView: WKWebView) {
        print("close")
    }
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        print("alert")
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .destructive, handler: { (action) in
            print("确定")
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
            print("取消")
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        print("confirm")
    }
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        print("textInput")
    }
    //实现该方法，可以弹出自定义视图
    @available(iOS 10.0, *)
    func webView(_ webView: WKWebView, shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool {
        return true
    }
    //实现该方法，可以弹出自定义视图控制器
    @available(iOS 10.0, *)
    func webView(_ webView: WKWebView, previewingViewControllerForElement elementInfo: WKPreviewElementInfo, defaultActions previewActions: [WKPreviewActionItem]) -> UIViewController? {
        return nil
    }
    //实现该方法，关闭自定义视图控制器
    func webView(_ webView: WKWebView, commitPreviewingViewController previewingViewController: UIViewController) {
        
    }
}
extension JXWkWebViewController:WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("start")
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("commit")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish")
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("fail:\(error.localizedDescription)")
    }
    
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
    }
    //监听页面跳转的代理方法，分为：收到跳转与决定是否跳转两种
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        
//    }
//    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//        
//    }
//    
//    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
//        
//    }
//    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        
//    }
//    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
//        
//    }
    
}

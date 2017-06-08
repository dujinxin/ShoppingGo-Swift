//
//  BaseViewController.swift
//  ShoppingGo-Swift
//
//  Created by 杜进新 on 2017/6/6.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - default view info
    
    /// default view
    lazy var defaultView: JXDefaultView = {
        let v = JXDefaultView()
        v.backgroundColor = UIColor.blue
        return v
    }()
    
    var defaultInfo : [String:String]?
    
    //log state
    var isLogin = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.white
        
        isLogin ? setUpMainView() : setUpDefaultView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    
    

}

extension BaseViewController {
    
    /// request data
    func requestData() {
        
    }
    
    /// request data
    ///
    /// - Parameter withPage: load data for page,
    func request(withPage:Int) {
        
    }
    //MARK: - base view set
    func setUpMainView() {
        //
    }
    
    /// add default view eg:no data,no network,no login
    func setUpDefaultView() {
        defaultView.frame = view.bounds
        view.addSubview(defaultView)
        defaultView.info = defaultInfo
        defaultView.tapBlock = {()->() in
            self.requestData()
        }
    }
}

extension BaseViewController {
    
}

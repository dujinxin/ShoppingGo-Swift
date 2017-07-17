//
//  JXTableViewController.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/6/7.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class JXTableViewController: BaseViewController{

    //tableview
    var tableView : UITableView?
    //refreshControl
    var refreshControl : UIRefreshControl?
    //data array
    var dataArray = Array<Any>()
    
    var style : UITableViewStyle = .plain{
        didSet{
            self.setTableView(style: style)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //isLogin ? setUpTableView() : setUpDefaultView()
        
        
        if self.style == .plain {
            setTableView(style: .plain)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension JXTableViewController : UITableViewDelegate,UITableViewDataSource{
    
    func setTableView(style:UITableViewStyle) {
        if self.tableView != nil && self.tableView?.superview != nil {
            self.tableView?.removeFromSuperview()
        }
        self.tableView = UITableView(frame: self.view.bounds, style: style)
        self.tableView?.backgroundColor = UIColor.groupTableViewBackground
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.view.insertSubview(self.tableView!, at: 0)
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(requestData), for: UIControlEvents.valueChanged)
        
        self.tableView?.addSubview(refreshControl!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

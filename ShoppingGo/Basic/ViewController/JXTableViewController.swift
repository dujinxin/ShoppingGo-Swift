//
//  JXTableViewController.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/6/7.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class JXTableViewController: BaseViewController{

    var tableView : UITableView?
    
    var refreshControl : UIRefreshControl?
    
    var dataArray = NSMutableArray()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(requestData), for: UIControlEvents.valueChanged)
        
        self.tableView?.addSubview(refreshControl!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}


extension JXTableViewController : UITableViewDelegate,UITableViewDataSource{
    
    func setUpTableView(){
        
        self.tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.tableView?.backgroundColor = UIColor.groupTableViewBackground
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.view.addSubview(self.tableView!)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

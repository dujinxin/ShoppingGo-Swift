//
//  MyViewController.swift
//  ShoppingGo-Swift
//
//  Created by 杜进新 on 2017/6/6.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit
import AFNetworking

private let cellId = "cellId"


class MyViewController: JXTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLogin = true
        

        self.customNavigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "登录", style: UIBarButtonItemStyle.plain, target: self, action: #selector(login))
        
        self.customNavigationItem.rightBarButtonItem = UIBarButtonItem.init(imageName: "title_icon_notice", target: self, action: #selector(nextPage))
        
        self.tableView?.frame = CGRect.init(x: 0, y: 64, width: self.view.bounds.size.width, height: UIScreen.main.bounds.size.height - 64 - 49)
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    
        //dataArray = NSMutableArray.init()
        dataArray.addObjects(from: ["12345","34567","234567","346578","678675645"])
        
        
        JXRequest.request(url: ApiString.getTokenByKey.rawValue, param: ["Uc":(UIDevice.current.identifierForVendor?.uuidString)!], success: { (data, msg) in
            print(data)
            guard let data = data as? Dictionary<String, Any> else{
                return
            }
            UserManager.default.saveUserInfo(dict: data)
            }, failure: { (msg, errorCode) in
                print(msg)
            })
 
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func requestData() {
        
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 4) { 
            
            self.refreshControl?.endRefreshing()
            self.dataArray.addObjects(from: ["12345","34567","234567","346578","678675645"])
            self.tableView?.reloadData()
        }
    }

    func login() {
        navigationController?.pushViewController(JXLoginViewController(), animated: true)
    }
    
    @objc private func nextPage() {
        let v = ViewController()
        v.title = "登录"
        navigationController?.pushViewController(v, animated: true)
        
    }

}

extension MyViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = dataArray[indexPath.row] as? String
        return cell
    }
}

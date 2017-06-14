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
        
        
        
        
        
        
        let longitude = 0
        let latitude = 0
        var parameters = ""
        let Channel = "appStore"
        let Mac = ""
        let IP = ""
        let City = "北京市"
        let token = ""
        
        parameters = "Version=2.0.1&Package=GjieGo&Channel=\(Channel)&Longitude=\(longitude)&Latitude=\(latitude)&Mac=\(Mac)&IP=\(IP)&City=\(City)"
        
        let ssss = "https://appc.guangjiego.com/v1/UserLogin/GetTokenByKey?\(parameters)"
        let sssss = ssss.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        
        let success = {(task:URLSessionDataTask, jsonData:Any?)->() in
            
        }
        let failure = {(task:URLSessionDataTask, error:Error)->() in
            
        }
        
        
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer.init()
        //manager.responseSerializer = AFHTTPResponseSerializer.j
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html") as? Set<String>
        
//        manager.post(sssss!, parameters: ["Uc":UIDevice.current.identifierForVendor?.uuidString], progress: nil, success: { (task:URLSessionDataTask, responseObject:Any?) in
//            print(responseObject ?? "空")
//            print(task)
//            //responseObject.
//            
//            let isJson = JSONSerialization.isValidJSONObject(responseObject)
//            print(isJson)
//            
//            guard let data = responseObject as? Data,
//                  let jsonData = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//            
//                else{
//                return
//            }
//
//            print(jsonData)
//
//        }) { (task:URLSessionDataTask?, error:Error) in
//            print(error)
//        }
        
        JXBaseRequest.request(url: "/UserLogin/GetTokenByKey", param: ["Uc":(UIDevice.current.identifierForVendor?.uuidString)!], success: { (responseObject:Any?, message:String?, alertType:String?) in
            //
            let isJson = JSONSerialization.isValidJSONObject(responseObject)
            print(isJson)
            //let jsons = JSONSerialization.jsonObject(with: <#T##InputStream#>, options: <#T##JSONSerialization.ReadingOptions#>)
            
            guard let data = responseObject as? Data,
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                
                else{
                    return
            }
            
            print("jsonData = \(jsonData) \n message = \(message) \n alertType = \(alertType)")
        }) { (task:URLSessionDataTask, error:Error?) in
            //
            print(error)
        }
        
        
//        var req = JXRequest(url: sssss!, param: ["Uc":(UIDevice.current.identifierForVendor?.uuidString)!]) { (task:URLSessionDataTask, responseObject:Any?, error:Error?) in
//            print(responseObject ?? "空")
//            print(task)
//            //responseObject.
//            
//            let isJson = JSONSerialization.isValidJSONObject(responseObject)
//            print(isJson)
//            
//            guard let data = responseObject as? Data,
//                let jsonData = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                
//                else{
//                    return
//            }
//            
//            print(jsonData)
//        }
        
        
        
        
        //https://appc.guangjiego.com/v1/UserLogin/GetTokenByKey?Version=2.0.1&Package=GjieGo&Channel=appStore&Longitude=0&Latitude=0&Mac=&IP=&City=%E5%8C%97%E4%BA%AC%E5%B8%82
        //https://appc.guangjiego.com/v1/UserLogin/GetTokenByKey?Version=2.0.1&Package=GjieGo&Channel=appStore&Longitude=0&Latitude=0&Mac=&IP=&City=%E5%8C%97%E4%BA%AC,
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

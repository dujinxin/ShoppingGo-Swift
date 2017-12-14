//
//  GroupUserManager.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/12/13.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import Foundation
import UIKit

private let groupBundleIdentifier = "group.com.zpsy.ShoppingGo"
private let pathComponent = "Library/Caches/userAccound.json"

class GroupUserModel: NSObject {
    
    @objc var Token : String?
    @objc var RefreshToken : String?
    @objc var PhoneNumber : String?
    @objc var UserID : Int = 0
    @objc var UserName : String?
    @objc var UserAge : Int = 0
    @objc var UserImage : String?
    @objc var UserGender : Int = 0
    @objc var HxAccount : String?
    @objc var HxPassword : String?
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
    }
}

class GroupUserManager {
    
    static let `default` = GroupUserManager()
    
    var userModel : GroupUserModel = GroupUserModel()
    /// 获得存储的路径
    var pathUrl: URL? {
        var url : URL?
//        if #available(iOS 11.0, *) {
//            url = NSFileProviderManager.default.documentStorageURL
//        } else {
            //获得当前的组的路径
            url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupBundleIdentifier)
//        }
        //返回拼接完毕的路径
        url?.appendPathComponent(pathComponent)
        
        return url
    }
    
    private init() {
        
        guard
            let url = self.pathUrl,
            let data = try? Data(contentsOf: url),
            let dict = try? JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,Any>
            else {
                print("用户地址不存在:\(String(describing: self.pathUrl))")
                return
        }
        self.userModel.setValuesForKeys(dict)
        print("用户地址：\(url)")
    }
    
    var isLogin: Bool {
        return self.userModel.UserID != 0
    }
    
    func saveUserInfo(dict: Dictionary<String,Any>) {
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []), let url = self.pathUrl
            else {
                return
        }
        do {
            try data.write(to: url, options: [])
            self.userModel = GroupUserModel()
            self.userModel.setValuesForKeys(dict)
            print("用户地址：\(url)")
        } catch {
            print("保存用户文件出错")
        }
    }
    func removeUserInfo() {
        guard let url = self.pathUrl, FileManager.default.fileExists(atPath: url.absoluteString) == true else { return }
        do {
            try FileManager.default.removeItem(atPath: url.absoluteString)
            self.userModel = GroupUserModel()
        } catch  {
            print("删除用户文件出错")
        }
    }
}


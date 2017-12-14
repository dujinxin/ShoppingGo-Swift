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
    var msg : String = "null"
    
    var userModel : GroupUserModel = GroupUserModel()
    /// 获得存储的路径
    var pathUrl: URL? {
        
        //获得当前的组的路径
        var url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupBundleIdentifier)
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
        //不起作用，不知为何，愁死......
        //MARK:找到原因了，是因为widget使用的swift4.0版本，而swift4.0的属性remove掉了set方法，从而导致属性设置出错，目前的解决方法是把属性定义为oc属性（加关键字@objc）
        userModel.setValuesForKeys(dict)
        
//        userModel.UserName = dict["UserName"] as? String
//        userModel.Token = dict["Token"] as? String
//        userModel.PhoneNumber = dict["PhoneNumber"] as? String
//        userModel.UserImage = dict["UserImage"] as? String
//        userModel.UserAge = dict["UserAge"] as? Int ?? 0
//        userModel.UserGender = dict["UserGender"] as? Int ?? 0
        
        print("用户地址：\(url)")
        msg = "用户地址：\(userModel.UserName)"
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

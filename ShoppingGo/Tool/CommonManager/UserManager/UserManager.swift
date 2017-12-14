//
//  UserManager.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/7/11.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import Foundation
import UIKit

private let userPath = NSHomeDirectory() + "/Documents/userAccound.json"

class UserModel: BaseModel {
    
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
    
}

class UserManager {
    
    static let `default` = UserManager()
    
    var userModel : UserModel = UserModel()
    
    private init() {
        let pathUrl = URL(fileURLWithPath: userPath)
        guard
            let data = try? Data(contentsOf: pathUrl),
            let dict = try? JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,Any>
        else {
            print("用户地址不存在：\(userPath)")
            return
        }
        //self.userModel = UserModel()
        self.userModel.setValuesForKeys(dict)
        
        print("用户地址：\(userPath)")
    }
    
    var isLogin: Bool {
        return self.userModel.UserID != 0
    }
    
    func saveUserInfo(dict: Dictionary<String,Any>) -> Bool {
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []),
              ((try? data.write(to: URL(fileURLWithPath:userPath), options: [])) != nil)
        else {
            return false
        }
        self.userModel = UserModel()
        self.userModel.setValuesForKeys(dict)
        print("用户地址：\(userPath)")
        return true
    }
    func removeUserInfo() -> Bool {
        guard
              FileManager.default.fileExists(atPath: userPath) == true,
             (try? FileManager.default.removeItem(atPath: userPath)) != nil
        else {
            return false
        }
        self.userModel = UserModel()
        return true
    }
}

extension UserManager {
    /// 刷新token
    ///
    /// - Parameter completion: 回调闭包
    func refreshToken(completion:((_ isSuccess:Bool)->())?) {
        //1.获取token,首次安装用本地生成的字符串来获取token
        //2.本地有保存token,则用长token去刷新token
        if
            let _ = UserManager.default.userModel.Token,
            let longToken = UserManager.default.userModel.RefreshToken{
            
            JXRequest.request(url: ApiString.refreshToken.rawValue, param: ["RToken":longToken], success: { (data, msg) in
                
                guard let data = data as? Dictionary<String, Any> else{
                    return
                }
                let isSuccess = UserManager.default.saveUserInfo(dict: data)
                let _ = JXUserDB.shareInstance.createTable(keys: Array(data.keys))
                let _ = JXUserDB.shareInstance.saveUserInfo(data: data)
                print("刷新token：\(isSuccess)")
                if let completion = completion {
                    completion(isSuccess)
                }
            }, failure: { (msg, code) in
                print(msg)
                if let completion = completion {
                    completion(false)
                }
            })
            
        }else{
            if let completion = completion {
                completion(false)
            }
            fetchToken()
        }
        
    }
    /// 获取token
    func fetchToken() {
        JXRequest.request(url: ApiString.getTokenByKey.rawValue, param: ["Uc":(UIDevice.current.identifierForVendor?.uuidString)!], success: { (data, msg) in
            
            guard let data = data as? Dictionary<String, Any> else{
                return
            }
            let isSuccess = UserManager.default.saveUserInfo(dict: data)
            print("保存token：\(isSuccess)")
            
        }, failure: { (msg, errorCode) in
            print(msg)
        })
    }
}

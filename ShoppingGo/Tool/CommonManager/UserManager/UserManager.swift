//
//  UserManager.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/7/11.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import Foundation

private let userPath = NSHomeDirectory() + "/Documents/userAccound.json"

class UserModel: BaseModel {
    
    var Token : String?
    var RefreshToken : String?
    var PhoneNumber : String?
    var UserID : Int = 0
    var UserName : String?
    var UserAge : Int = 0
    var UserImage : String?
    var UserGender : Int = 0
    var HxAccount : String?
    var HxPassword : String?
    
}

class UserManager {
    
    static let `default` = UserManager()
    
    var userModel = UserModel()
    
    init() {
        let pathUrl = URL(fileURLWithPath: userPath)
        guard
            let data = try? Data(contentsOf: pathUrl),
            let dict = try? JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,Any>
        else {
            print("用户地址不存在：\(userPath)")
            return
        }
        self.userModel.setValuesForKeys(dict)
        print("用户地址：\(userPath)")
    }
    
    func saveUserInfo(dict: Dictionary<String,Any>) -> Bool {
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []),
              ((try? data.write(to: URL(fileURLWithPath:userPath), options: [])) != nil)
        else {
            return false
        }
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
        return true
    }
}

//
//  JXUserDB.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/8/17.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

private let dbName = "JXUserDB"

class JXUserDB: JXBaseDB {

    static let shareInstance = JXUserDB(name: dbName)
    
    var userModel : UserModel = UserModel()

    override init(name: String) {
        super.init(name: name)
        setUserInfo()
    }
    /// 用户数据初始化
    func setUserInfo() {
        if
            self.manager.isExist == true,
            let data = self.selectData(),
            data.isEmpty == false{
            
            userModel.setValuesForKeys(data[0] as! [String : Any])
        }
    }
    /// 保存用户数据
    ///
    /// - Parameter data: 用户数据
    /// - Returns: 返回结果
    func saveUserInfo(data: Dictionary<String, Any>) -> Bool {
        if let dataArray = self.selectData(),
            dataArray.isEmpty == false{
            let isSuccess = self.updateData(keyValues: data)
            if isSuccess {
                userModel.setValuesForKeys(data)
            }
            return isSuccess
        }else{
            let isSuccess = self.insertData(data: data)
            if isSuccess {
                userModel.setValuesForKeys(data)
            }
            return isSuccess
        }
    }
    /// 修改用户昵称
    ///
    /// - Parameter name: 昵称
    /// - Returns: 返回结果
    func modify(name:String) -> Bool {
        let cs = "UserID = \(userModel.UserID)"
        let isSuccess = self.updateData(keyValues: ["UserName":name], condition: [cs])
        if isSuccess {
            userModel.UserName = name
        }
        return isSuccess
    }
    /// 修改用户头像
    ///
    /// - Parameter image: 头像地址
    /// - Returns: 返回结果
    func modify(image:String) -> Bool {
        let cs = "UserID = \(userModel.UserID)"
        let isSuccess = self.updateData(keyValues: ["UserImage":image], condition: [cs])
        if isSuccess {
            userModel.UserImage = image
        }
        return isSuccess
    }
    /// 修改用户性别
    ///
    /// - Parameter image: 性别
    /// - Returns: 返回结果
    func modify(gender:String) -> Bool {
        let cs = "UserID = \(userModel.UserID)"
        let isSuccess = self.updateData(keyValues: ["UserGender":gender], condition: [cs])
        if isSuccess {
            userModel.UserGender = Int(gender)!
        }
        return isSuccess
    }
}

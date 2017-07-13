
//
//  ApiEnum.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/6/9.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import Foundation

enum ApiString : String {
    case getTokenByKey = "/UserLogin/GetTokenByKey" //获取token
    case refreshToken  = "/UserLogin/RefreshToken"  //刷新token
    case userLogin     = "/UserLogin/Login"
}

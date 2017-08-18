//
//  BaseModel.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/7/11.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class BaseModel: NSObject {

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("undefineKey:\(key)")
    }
}

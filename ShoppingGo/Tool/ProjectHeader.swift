//
//  ProjectHeader.swift
//  ZPOperator
//
//  Created by 杜进新 on 2017/7/7.
//  Copyright © 2017年 dujinxin. All rights reserved.
//

import Foundation

//let kBaseUrl = "http://192.168.10.12:8086"
//let getTokenUrl     = "http://192.168.10.12:8082/genuine/user/getUploadToken"

let kBaseUrl = "https://operator.izheng.org"
let getTokenUrl  = "https://app.izheng.org/genuine/user/getUploadToken"


let isShowLog : Bool = true
let isDebug : Bool = true


/// 打印信息
///
/// - Parameters:
///   - msg: 要输出的信息
///   - file: 文件名
///   - line: 方法所在行数
///   - function: 方法名称
func print<T>(_ msg:T,file:String = #file,line:Int = #line,function:String = #function) {
    
    let fileName = (file as NSString).lastPathComponent
    print("[\(Date(timeIntervalSinceNow: 0))]",fileName,line,function,"\n",msg, separator: " ", terminator: "\n")
}

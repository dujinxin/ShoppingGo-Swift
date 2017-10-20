//
//  JXNavigationBar.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/10/20.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class JXNavigationBar: UINavigationBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    override func layoutSubviews() {
        super.layoutSubviews()
        var rect = CGRect(x: 0, y: 0, width: kScreenWidth, height: kNavStatusHeight)
        
        self.subviews.forEach { (v) in
            if NSStringFromClass(type(of: v)).contains("UIBarBackground") {
                v.frame = rect
            }else if NSStringFromClass(type(of: v)).contains("UINavigationBarContentView") {
                rect.origin.y += kStatusBarHeight
                rect.size.height -= kStatusBarHeight
                v.frame = rect
            }
        }
    }
}

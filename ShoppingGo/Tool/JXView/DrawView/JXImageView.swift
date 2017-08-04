//
//  JXImageView.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/7/28.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class JXImageView: UIView {

    var imageView : UIImageView?
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        UIGraphicsBeginImageContextWithOptions(frame.size, true, 0)
        
        let image = #imageLiteral(resourceName: "location_address_none")
        
        //在指定区域画图，图片会被拉伸
        //image.draw(in: bounds)
        //在指定点(作为起始点)作图，图片保持自身大小
        //image.draw(at: rect.origin)
        //在指定区域，平铺图片
        image.drawAsPattern(in: rect)
        
        //image.draw(at: <#T##CGPoint#>, blendMode: <#T##CGBlendMode#>, alpha: <#T##CGFloat#>)
        //image.draw(in: <#T##CGRect#>, blendMode: <#T##CGBlendMode#>, alpha: <#T##CGFloat#>)
        
        imageView?.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        imageView = UIImageView()

        addSubview(imageView!)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

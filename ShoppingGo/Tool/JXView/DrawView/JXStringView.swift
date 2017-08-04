//
//  JXStringView.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/7/28.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class JXStringView: UIView {
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        super.draw(rect)
        
        let text : NSString = "曾经以为，这样的一见如故，会是我今生最美丽的相遇;曾经以为，这样的一诺相许，会是我素色年华里最永恒的风景;曾经以为，这样的心心相印，会是我无怨无悔的追逐。却不知，繁华有时，落寞有时，却怎么也读不懂我心头的一丝缠绵..."
        let paragraph = NSMutableParagraphStyle.init()
        paragraph.lineSpacing = 5
        let attributes = [
            NSFontAttributeName:UIFont.boldSystemFont(ofSize: UIFont.labelFontSize),
            NSForegroundColorAttributeName:UIColor.red,
            NSBackgroundColorAttributeName:UIColor.yellow,
            NSParagraphStyleAttributeName:paragraph
            ] as [String : Any]
        //从指定点开始绘制，不会换行
        //text.draw(at: rect.origin, withAttributes: attributes)
        //在指定区域绘制，会自动换行，超出部分不显示
        //text.draw(in: rect, withAttributes: attributes)
        //更多限制
        text.draw(with: rect, options: [.usesFontLeading,.usesLineFragmentOrigin], attributes: attributes, context: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

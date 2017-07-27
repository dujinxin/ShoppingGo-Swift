//
//  UIImageView+Extension.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/7/19.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func jx_setImage(with urlStr:String, placeholderImage: UIImage?,radius:CGFloat = 0){
        
        guard let url = URL(string: urlStr) else {
            self.image = placeholderImage
            return
        }
        self.sd_setImage(with: url, placeholderImage: placeholderImage, options: [], progress: nil) { (image, error, _, url) in
            if
                let image = image,
                radius > 0{
                
                self.image = UIImage.image(originalImage: image, rect: self.bounds, radius: radius)
            }
        }
    }
    
}

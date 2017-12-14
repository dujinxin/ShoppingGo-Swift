//
//  JXViewManager.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/8/4.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

import MBProgressHUD

class JXViewManager {
    static let manager = JXViewManager()
    
    var hud : MBProgressHUD?
    var noticeView : JXNoticeView?
    
    
    private init() {
        
    }

}


extension JXViewManager {
    
    ///MBProgressHUD loading view
    func showMBProgressHUD(view:UIView) {
        hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.bezelView.color = UIColor.rgbColor(rgbValue: 0x333333, alpha: 0.8)
        hud?.label.text = "编辑成功"
        //hud?.customView = UIImageView(image: #imageLiteral(resourceName: "address_selected"))
        hud?.customView = UIImageView.init(image: #imageLiteral(resourceName: "share_default"))
        hud?.mode = .customView
        hud?.removeFromSuperViewOnHide = true
    }
    func hideMBProgressHUD(view:UIView) {
        //MBProgressHUD.hide(for: view, animated: true)
        
        if let hud = hud {
            //hud.hide(animated: true)
            hud.hide(animated: true, afterDelay: 2)
        }
    }
    
    ///JXNoticeView 
    
    func showJXNoticeView(notice:String) {
        
        if let hud = hud {
            hud.hide(animated: true)
        }
        noticeView = nil
        
        noticeView = JXNoticeView(text: notice)
        noticeView?.show()
    }
}

extension JXViewManager {
    func pushViewController(_ viewController:UIViewController) {
        if let vc = UIViewController.topStackViewController {
            vc.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    func presentViewController(_ viewController:UIViewController) {
        if let vc = UIViewController.topStackViewController {
            vc.present(viewController, animated: true, completion: {})
        }
    }
}

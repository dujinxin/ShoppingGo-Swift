//
//  JXOrderManageController.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/10/24.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class JXOrderManageController: JXBaseViewController,JXTopBarViewDelegate,JXHorizontalViewDelegate{
    
    var topBar : JXTopBarView?
    var horizontalView : JXHorizontalView?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "订单管理"
        
        topBar = JXTopBarView.init(frame: CGRect.init(x: 0, y: kNavStatusHeight, width: view.bounds.width, height: 44), titles: ["待付款","待发货","待收货","待评价"])
        topBar?.delegate = self
        topBar?.isBottomLineEnabled = true
        view.addSubview(topBar!)
        
        horizontalView = JXHorizontalView.init(frame: CGRect.init(x: 0, y: kNavStatusHeight + 44, width: view.bounds.width, height: UIScreen.main.bounds.height - kNavStatusHeight - 44), containers: [JXOrderListController(),JXOrderListController(),JXOrderListController(),JXOrderListController()], parentViewController: self)
        view.addSubview(horizontalView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension JXOrderManageController {
    func jxTopBarView(topBarView: JXTopBarView, didSelectTabAt index: Int) {
        let indexPath = IndexPath.init(item: index, section: 0)
        //开启动画会影响topBar的点击移动动画
        self.horizontalView?.containerView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: false)
    }
    func horizontalViewDidScroll(scrollView:UIScrollView) {
        var frame = self.topBar?.bottomLineView.frame
        let offset = scrollView.contentOffset.x
        frame?.origin.x = (offset / kScreenWidth ) * (kScreenWidth / CGFloat((self.topBar?.titles.count)!))
        self.topBar?.bottomLineView.frame = frame!
    }
    func horizontalView(_: JXHorizontalView, to indexPath: IndexPath) {
        //
        if self.topBar?.selectedIndex == indexPath.item {
            return
        }
        resetTopBarStatus(index: indexPath.item)
    }
    
    func resetTopBarStatus(index:Int) {
        
        self.topBar?.selectedIndex = index
        self.topBar?.subviews.forEach { (v : UIView) -> () in
            
            if (v is UIButton){
                let btn = v as! UIButton
                if (v.tag != self.topBar?.selectedIndex){
                    btn.isSelected = false
                }else{
                    btn.isSelected = !btn.isSelected
                }
            }
        }
    }
}

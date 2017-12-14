//
//  HomeViewController.swift
//  ShoppingGo-Swift
//
//  Created by 杜进新 on 2017/6/6.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class HomeViewController: JXBaseViewController {

    lazy var additionView: JXAdditionView = {
        let addition = JXAdditionView(frame: CGRect())
        addition.arrowPoint = CGPoint(x: kScreenWidth - 25, y: 67)
        addition.dataSource = self
        
        return addition
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customNavigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(additionClick))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func additionClick() {
        let addition = JXAdditionView(frame: CGRect())
        addition.arrowPoint = CGPoint(x: kScreenWidth - 25, y: 67)
        addition.dataSource = self
        addition.delegate = self
        addition.show()
    }
}
extension HomeViewController:JXAdditionViewDataSource,JXAdditionViewDelegate{
    func jxAdditionView(_: JXAdditionView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func jxAdditionView(_: JXAdditionView, contentForRow row: Int, InSection section: Int) -> String {
        return "\(row)"
    }
    func jxAdditionView(_: JXAdditionView, widthForComponent component: Int) -> CGFloat {
        return 200
    }
    func jxAdditionView(_: JXAdditionView, heightForRowAt row: Int) -> CGFloat {
        return 44
    }
    func jxAdditionView(_: JXAdditionView, didSelectRowAt row: Int) {
        print("click:\(row)")
    }
    
}

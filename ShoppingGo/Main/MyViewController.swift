//
//  MyViewController.swift
//  ShoppingGo-Swift
//
//  Created by 杜进新 on 2017/6/6.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class MyViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "title_icon_notice"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(nextPage))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func nextPage() {
        let v = ViewController()
        navigationController?.pushViewController(v, animated: true)
        
    }

}

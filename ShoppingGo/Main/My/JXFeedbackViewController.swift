//
//  JXFeedbackViewController.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/8/10.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class JXFeedbackViewController: JXBaseViewController {
    
    lazy var textView: JXPlaceHolderTextView = {
        //        let textView = JXPlaceHolderTextView(frame: CGRect(x: 10, y:kNavStatusHeight + 10, width: kScreenWidth - 20, height: 80), textContainer: NSTextContainer(size: CGSize(width: 100, height: 44)))
        let textView = JXPlaceHolderTextView(frame: CGRect(x: 10, y:kNavStatusHeight + 10, width: kScreenWidth - 20, height: 80))
        textView.placeHolderText = "为了寻你，我错过了许许许多多的良辰美景!"
        textView.delegate = self
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }
}

extension JXFeedbackViewController : UITextViewDelegate{
    override func setUpMainView() {

        view.addSubview(self.textView)

        //self.textView.text = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
        
        NotificationCenter.default.addObserver(self, selector: #selector(placeHolderTextChange(nofiy:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
        
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //限制输入字符个数
        if range.location >= 100{
            
            self.showNotice(notice: "字符个数不能大于100")
            return false
        }
        //return键 收键盘
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func placeHolderTextChange(nofiy:Notification) {
        
    }
}

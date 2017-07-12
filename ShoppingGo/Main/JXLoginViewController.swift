//
//  JXLoginViewController.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/6/13.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class JXLoginViewController: BaseViewController {

    lazy var userTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.leftViewMode = UITextFieldViewMode.always
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        textField.clearButtonMode = UITextFieldViewMode.whileEditing
        textField.returnKeyType = UIReturnKeyType.next
        textField.delegate = self
        textField.leftView = {
            let iv = UIImageView()
            
            return iv
        }()
        textField.placeholder = "请输入手机号"
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .valueChanged)
        return textField
    }()
    
    lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.leftViewMode = UITextFieldViewMode.always
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        textField.clearButtonMode = UITextFieldViewMode.whileEditing
        textField.returnKeyType = UIReturnKeyType.join
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.leftView = {
            let iv = UIImageView()
            
            return iv
        }()
        textField.placeholder = "请输入密码"
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .valueChanged)
        return textField
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "登录"
        
        setUpMainView()
        
        userTextField.text = "13121273646"
        passwordTextField.text = "123456"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension JXLoginViewController : UITextFieldDelegate{
    
    override func setUpMainView() {
        
        view.addSubview(userTextField)
        view.addSubview(passwordTextField)
        
        let loginButton : UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("登录", for: UIControlState.normal)
            button.setTitleColor(UIColor.jx333333Color, for: .normal)
            button.backgroundColor = UIColor.yellow
            button.layer.cornerRadius = 5;
            button.addTarget(self, action: #selector(login), for: .touchUpInside)
            return button
        }()
        view.addSubview(loginButton)
        
        
        //userTextField
        view.addConstraint(NSLayoutConstraint(item: userTextField, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 64.0 + 44.0))
        view.addConstraint(NSLayoutConstraint(item: userTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: userTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0))
        view.addConstraint(NSLayoutConstraint(item: userTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.bounds.width - 44.0 * 2))
        
        //passwordTextField
        view.addConstraint(NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: userTextField, attribute: .bottom, multiplier: 1.0, constant: 20))
        view.addConstraint(NSLayoutConstraint(item: passwordTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0))
        view.addConstraint(NSLayoutConstraint(item: passwordTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.bounds.width - 44.0 * 2))
        
        //loginButton
        view.addConstraint(NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: passwordTextField, attribute: .top, multiplier: 1.0, constant: 64.0 + 44.0))
        view.addConstraint(NSLayoutConstraint(item: loginButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: loginButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0))
        view.addConstraint(NSLayoutConstraint(item: loginButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.bounds.width - 44.0 * 2))
    }
    
    override func setUpDefaultView() {
        
    }
    
    func textFieldEditingChanged() {
        
    }
    func login() {
        JXRequest.request(url: ApiString.userLogin.rawValue, param: ["ua":userTextField.text!,"Up":passwordTextField.text!], success: { (data, msg) in
            print(data)
        }) { (msg, errorCode) in
            print(msg)
        }
    }
}

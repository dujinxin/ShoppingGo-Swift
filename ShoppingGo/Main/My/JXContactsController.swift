//
//  JXContactsController.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/10/24.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit
import AddressBook

class JXContactsController: JXTableViewController {
    
    var addressBook = ABAddressBookCreate()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        ABAddressBookRequestAccessWithCompletion(addressBook as ABAddressBook) { (isSuccess, cfError) in
            //
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

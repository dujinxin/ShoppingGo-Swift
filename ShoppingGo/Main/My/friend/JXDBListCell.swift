//
//  JXDBListCell.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/8/16.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class JXDBListCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var model: DBUserModel! {
        didSet{
            nameLabel.text = model.name
            ageLabel.text = "\(model.age)"
            genderLabel.text = model.gender == 0 ? "男":"女"
            scoreLabel.text = "\(model.score)"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

class DBUserModel: BaseModel {
    var id : Int = 0
    
    var name : String?
    var age : Int = 18
    var gender : Int = 0 //0为男，1位女 
    var score : Int = 0
}

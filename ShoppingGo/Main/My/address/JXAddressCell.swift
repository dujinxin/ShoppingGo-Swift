//
//  JXAddressCell.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/8/10.
//  Copyright © 2017年 杜进新. All rights reserved.
//

import UIKit

class JXAddressCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var defaultButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func defaultAction(_ sender: UIButton) {
        
        if model?.isDefault == 0 {
            model?.isDefault = 1
            defaultButton.setImage(UIImage(named: "address_selected"), for:.normal )
        }else{
            model?.isDefault = 0
            defaultButton.setImage(UIImage(named: "address_unselected"), for:.normal )
        }
        if let defaultBlock = defaultBlock {
            defaultBlock()
        }
    }
    @IBAction func editAction(_ sender: UIButton) {
        if let editBlock = editBlock {
            editBlock()
        }
    }
    @IBAction func deleteAction(_ sender: UIButton) {
        if let deleteBlock = deleteBlock {
            deleteBlock()
        }
    }
    
    var defaultBlock : (()->())?
    var editBlock : (()->())?
    var deleteBlock : (()->())?
    
    var model: JXAddressEntity? {
        didSet{
            
            nameLabel.text = model?.name
            phoneLabel.text = model?.phone
            addressLabel.text = model?.address
            if model?.isDefault == 0 {
                defaultButton.setImage(UIImage(named: "address_unselected"), for:.normal )
            }else{
                defaultButton.setImage(UIImage(named: "address_selected"), for:.normal )
            }
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

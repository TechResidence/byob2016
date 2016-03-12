//
//  ApprovalTableViewCell.swift
//  petty-pay
//
//  Created by Hiroki Matsue on 3/12/16.
//  Copyright © 2016 Petty Pay Team. All rights reserved.
//

import UIKit

class ApprovalTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userTypeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var itemTypeLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func construct(purchase: Purchase) {
        userImageView.image = purchase.user.image
        userNameLabel!.text = purchase.user.name
        userImageView.image = purchase.user.image
        userNameLabel.text = purchase.user.name
        userTypeLabel.text = purchase.user.type
        itemNameLabel.text = purchase.item.name
        itemPriceLabel.text = String(purchase.item.price)
    }
    
}

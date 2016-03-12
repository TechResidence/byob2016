//
//  Purchase.swift
//  petty-pay
//
//  Created by Hiroki Matsue on 3/12/16.
//  Copyright © 2016 Petty Pay Team. All rights reserved.
//

import UIKit

class Purchase: NSObject {
    
    var user: User
    var item: Item
    
    init(user: User, item: Item) {
        self.user = user
        self.item = item
    }
    
}

//
//  Item.swift
//  petty-pay
//
//  Created by Hiroki Matsue on 3/12/16.
//  Copyright © 2016 Petty Pay Team. All rights reserved.
//

import UIKit

class Item: NSObject {
    
    var name: String = ""
    var type: String = ""
    var price: Int = 0
    
    init(name: String, type: String, price: Int) {
        self.name = name
        self.type = type
        self.price = price
    }
    
}

//
//  User.swift
//  petty-pay
//
//  Created by Hiroki Matsue on 3/12/16.
//  Copyright © 2016 Petty Pay Team. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String = ""
    var type: String = ""
    var image: UIImage
    
    init(name: String, type: String, image: UIImage) {
        self.name = name
        self.type = type
        self.image = image
    }
    
}

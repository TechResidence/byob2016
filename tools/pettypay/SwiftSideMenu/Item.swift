//
//  Item.swift
//  SwiftSideMenu
//
//  Created by AsukaKadowaki on 2016/02/15.
//  
//

import UIKit

class Item: NSObject {
    let id: String
    let title: String
    let contents: String
    let imageUrl: String
    let paybackTypes: [String]
    let reviewScore: String
    let lat: String
    let lng: String
    
    init(id: String, title: String, contents: String, imageUrl: String?, paybackTypes: [String]?, reviewScore: String, lat: String, lng: String) {
        self.id = id
        self.title = title
        self.contents = contents
        self.imageUrl = imageUrl ?? ""
        self.paybackTypes = paybackTypes ?? []
        self.reviewScore = "2"
        self.lat = lat
        self.lng = lng
    }
}

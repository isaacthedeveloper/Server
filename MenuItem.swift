//
//  MenuItem.swift
//  Server
//
//  Created by Isaac Ballas on 2019-12-06.
//  Copyright © 2019 Isaac Ballas. All rights reserved.
//

import UIKit
/*
 The highest level of information returned by the API is a key called `items` that contains an array of all the menu items in JSON format. Because of this, you will need an intermediary MenuItems object that conform to Codable and has a property called items so that the JSON data can be decoded properly. You can then access the array of itms through this object. You can place this intermediart object in the same file as MenuItem.
 */
struct MenuItem: Codable {
    var id: Int
    var name: String
    var detailText: String
    var price: Double
    var category: String
    var imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case detailText = "description"
        case price
        case category
        case imageURL = "image_url"
    }
     
}


struct MenuItems: Codable {
    let items: [MenuItem]
}

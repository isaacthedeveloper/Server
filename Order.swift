//
//  Order.swift
//  Server
//
//  Created by Isaac Ballas on 2019-12-06.
//  Copyright © 2019 Isaac Ballas. All rights reserved.
//

import Foundation
struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}

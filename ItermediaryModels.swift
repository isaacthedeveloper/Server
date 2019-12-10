//
//  ItermediaryModels.swift
//  Server
//
//  Created by Isaac Ballas on 2019-12-06.
//  Copyright © 2019 Isaac Ballas. All rights reserved.
//
/*
 The API can also return a list of categories. This list is an array of strings under the key `categories` so you need an intermediate object. In this case it will be Categories and should have a property called categories of type [String].
 */
import Foundation
struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    let prepTime: Int
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}

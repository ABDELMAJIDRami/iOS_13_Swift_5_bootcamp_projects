//
//  Item.swift
//  Todoey
//
//  Created by user183479 on 12/15/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

// struct Item: Encodable, Decodable {
struct Item: Codable {
    var title: String = ""
    var done: Bool = false
}

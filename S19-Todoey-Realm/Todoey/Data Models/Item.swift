//
//  Item.swift
//  Todoey
//
//  Created by user183479 on 12/19/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items") // belongs-to relationship
    // belongs to (foreign key) "items" in table Category
}

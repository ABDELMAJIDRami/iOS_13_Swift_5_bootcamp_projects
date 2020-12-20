//
//  Category.swift
//  Todoey
//
//  Created by user183479 on 12/19/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String?
    let items = List<Item>()    // represent Realm to-many relationship
    }

/*
 exeplication on declaring Arrays:  all are the same
 
 let array = [1, 2, 3]
 let array = [Int]() // array of empty integers
 let array: [Int] = [1, 2, 3]
 let array: Array<Int> = [1, 2, 3]
 let array =  Array<Int>()  // array of empty integers

 */

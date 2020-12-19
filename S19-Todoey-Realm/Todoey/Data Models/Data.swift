//
//  Data.swift
//  Todoey
//
//  Created by user183479 on 12/19/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {  // Object is a class used to define Realm model objects(Define a sql table).
    @objc dynamic var name: String = ""   // giving intial values to our props(columns)
    @objc dynamic var age: Int = 0
}

/* Because we're using Realm, we actually need to mark our variables with the keyword "dynamic." And there's a long and short answer as to what dynamic means. So the complex answer is that dynamic is what's called a declaration modifier. It basically tells the runtime to use dynamic dispatch over the standard which is a static dispatch. And this basically allows this property name to be monitored for change at runtime, i.e., while your app is running. So that means if the user changes the value of name, for example, while the app is running, then that allows Realm to dynamically update those changes in the database. But dynamic dispatch is something that actually comes from the Objective-C APIs. So that means that we have to mark dynamic with at Objective-C to be explicit that we are using the Objective-C runtime. Now, the simple answer as to why we just added these two keywords in there is that we need to add these two modifiers, basically, so that Realm can monitor for changes in the value of this property, and this is what we'll allow us to do it while the app is running.*/

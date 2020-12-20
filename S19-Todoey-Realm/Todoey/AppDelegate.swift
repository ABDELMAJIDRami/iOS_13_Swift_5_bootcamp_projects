 //
//  AppDelegate.swift
//  Destini
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Locate our Realm configuration/database
        print(Realm.Configuration.defaultConfiguration.fileURL)
                
        // let data = Data()
        // data.name = "Rami"
        // data.age = 25
        
        // So let's go ahead and add our new item, i.e., create in CRUD, and we're going to commit the current state of our Realm. So just as we did with Core Data, we basically created a new piece of data, then we used the context to commit the current state to our persistent container, or in this case, it's our Realm database
        
        do {// we kept the following line for initilisation but i beleive we can delete it also cz we are initializing it inside CategoryViewController. She said she kep the initialosation to catch any error when we are initializing a new error
            _ = try Realm() // A Realm instance (also referred to as “a Realm”) represents a Realm database. like persistance container
            // try realm.write { //If the block throws an error, the transaction will be canceled and any changes made before the error will be rolled back.
                // realm.add(data)
            // }
        } catch {
            print("Erorr initialising new realm, \(error)")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        // check description above
        print("applicationWillResignActive")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        print("applicationWillEnterForeground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("applicationDidBecomeActive")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // can be user triggered or system triggered to reclaime and rellocate resources
        // Saves changes in the applications's managed object context before the application terminates.
        print("applicationWillTerminate")
    }
}


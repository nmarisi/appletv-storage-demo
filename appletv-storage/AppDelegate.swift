//
//  AppDelegate.swift
//  appletv-storage
//
//  Created by Nahuel Marisi on 2015-10-24.
//  Copyright © 2015 TechBrewers. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let textKey = "textKey"


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "storeDidChange:",
                name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification,
                object: NSUbiquitousKeyValueStore.defaultStore())
        
        // Download any changes since the last time this instance of the app was launched
        NSUbiquitousKeyValueStore.defaultStore().synchronize()
        
        return true
    }
    
    func storeDidChange(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
       
        guard let reasonForChange = userInfo[NSUbiquitousKeyValueStoreChangeReasonKey] as? NSNumber else {
            return
        }
        
        // Update local values only if we find server changes
        let reason = reasonForChange.integerValue
       
        if reason == NSUbiquitousKeyValueStoreServerChange ||
            reason == NSUbiquitousKeyValueStoreInitialSyncChange {
                
                // Get Changes
                let changedKeys = userInfo[NSUbiquitousKeyValueStoreChangedKeysKey] as! [AnyObject]
                let store = NSUbiquitousKeyValueStore.defaultStore()
                
                
                // Print keys that have changed
                for key in changedKeys {
                    let value = store.objectForKey(key as! String)
                    print("key: \(key), value: \(value)")
                    
                }
        }
     }
}


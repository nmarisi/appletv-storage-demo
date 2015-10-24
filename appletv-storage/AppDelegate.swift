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
        let reasonForChange = userInfo[NSUbiquitousKeyValueStoreChangeReasonKey] as? NSNumber
        var reason = -1
        
        if reasonForChange == nil {
            return
        }
        
        // Update local values only if we find server changes
        reason = reasonForChange!.integerValue
       
        if reason == NSUbiquitousKeyValueStoreServerChange ||
            reason == NSUbiquitousKeyValueStoreInitialSyncChange {
                
                // Get Changes
                let changedKeys = userInfo[NSUbiquitousKeyValueStoreChangedKeysKey] as! [AnyObject]
                let store = NSUbiquitousKeyValueStore.defaultStore()
                let userDefaults = NSUserDefaults.standardUserDefaults()
                
                // We assume you use the same key for both NSUserDefaults and iCloud KVO
                for key in changedKeys {
                    let value = store.objectForKey(key as! String)
                    userDefaults.setObject(value, forKey: key as! String)
                    
                }
            
        }
    }
    
        
        
        
        
      func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


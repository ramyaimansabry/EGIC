//
//  AppDelegate.swift
//  EGIC
//
//  Created by Ramy Ayman Sabry on 7/5/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        
        
        
        KingfisherManager.shared.cache.diskStorage.config.expiration = .seconds(60 * 60 * 24 * 7)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        if let loggedInClient = UserDefaults.standard.dictionary(forKey: "loggedInClient"){
            HelperData.sharedInstance.loggedInClient._id = loggedInClient["user_id"] as! Int
            HelperData.sharedInstance.loggedInClient.name = loggedInClient["name"] as! String
            HelperData.sharedInstance.loggedInClient.mobile = loggedInClient["mobile"] as! String
            HelperData.sharedInstance.loggedInClient.token = loggedInClient["token"] as! String
        }
        
        return true
    }
    
    
    

    func applicationWillResignActive(_ application: UIApplication) {
      
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
    }


}


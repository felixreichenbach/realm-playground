//
//  AppDelegate.swift
//  Realm-Playground
//
//  Created by Felix Reichenbach on 04.05.20.
//  Copyright © 2020 Felix Reichenbach. All rights reserved.
//

import UIKit
import StitchCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Initialize Stitch Client
        do {
            _ = try Stitch.initializeDefaultAppClient(
                withClientAppID: Constants.STITCH_APP_ID
            )
            NSLog("Successfully initialized default Stitch app client!");
        } catch {
            // note: This initialization will only fail if an incomplete configuration is
            // passed to a client initialization method, or if a client for a particular
            // app ID is initialized multiple times. See the documentation of the "Stitch"
            // class for more details.
            NSLog("Failed to initialize MongoDB Stitch iOS SDK: \(error)")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


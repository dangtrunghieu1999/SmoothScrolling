//
//  AppDelegate.swift
//  TableView
//
//  Created by Bee_MacPro on 16/02/2022.
//

import UIKit
import WatchdogInspector

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        TWWatchdogInspector.start()
        return true
    }

}


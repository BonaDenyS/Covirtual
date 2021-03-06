//
//  AppDelegate.swift
//  Covirtual
//
//  Created by Bona Deny S on 09/04/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator?.start()
        
        return true
    }


}


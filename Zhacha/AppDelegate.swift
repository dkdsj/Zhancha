//
//  AppDelegate.swift
//  Zhacha
//
//  Created by ZZ on 2019/9/2.
//  Copyright © 2019 ZZ. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds);
        window?.rootViewController = MainTabBarVC()
        window?.makeKeyAndVisible()

        return true
    }

}


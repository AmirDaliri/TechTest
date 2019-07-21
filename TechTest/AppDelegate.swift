//
//  AppDelegate.swift
//  TechTest
//
//  Created by Amir Daliri on 19.07.2019.
//  Copyright © 2019 AmirDaliri. All rights reserved.
//

import UIKit
import PieCrust

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = showFeedController()
        return true
    }

    func showFeedController() -> PCWindow {
        return PCWindow(rootViewController: PCNavigationController(rootViewController: MainViewController()))
    }
}


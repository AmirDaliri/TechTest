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
        
        window = showLaunchScreenController()
        checkNetwork()
        return true
    }

    func showLaunchScreenController() -> PCWindow {
        return PCWindow(rootViewController: LaunchScreenViewController())
    }
    
    func showFeedController() -> PCWindow {
        return PCWindow(rootViewController: PCNavigationController(rootViewController: MainViewController()))
    }
    
    func checkNetwork() {
        do {
            try Network.reachability = Reachability(hostname: "www.google.com") // or "https://www.reddit.com"
        }
        catch {
            switch error as? Network.Error {
            case let .failedToCreateWith(hostname)?:
                print("Network error:\nFailed to create reachability object With host named:", hostname)
            case let .failedToInitializeWith(address)?:
                print("Network error:\nFailed to initialize reachability object With address:", address)
            case .failedToSetCallout?:
                print("Network error:\nFailed to set callout")
            case .failedToSetDispatchQueue?:
                print("Network error:\nFailed to set DispatchQueue")
            case .none:
                print(error)
            }
        }
    }
}


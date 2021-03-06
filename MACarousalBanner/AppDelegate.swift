//
//  AppDelegate.swift
//  MACarousalBanner
//
//  Created by Mahjabin Alam on 2022/07/10.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = DemoViewController()
        window?.makeKeyAndVisible()
        return true
    }

} 


//
//  AppDelegate.swift
//  InterestsCollection
//
//  Created by Alexander Nikolaychuk on 09.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let vc = ViewController()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        return true
    }
}

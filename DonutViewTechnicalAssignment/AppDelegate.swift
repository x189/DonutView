//
//  AppDelegate.swift
//  DonutViewTechnicalAssignment
//
//  Created by Aleksandar Drazhev on 20.01.19.
//  Copyright © 2019 Aleksandar Drazhev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.isTranslucent = false
        
        if let donutViewController = DonutConfigurator.newDonutModule() {
            navigationController.pushViewController(donutViewController, animated: false)
        }
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}


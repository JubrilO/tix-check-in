//
//  AppDelegate.swift
//  tix
//
//  Created by Jubril on 18/11/2018.
//  Copyright © 2018 Tix. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navVC = UINavigationController()
        coordinator = MainCoordinator(navVC: navVC)
        coordinator?.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        return true
    }
}


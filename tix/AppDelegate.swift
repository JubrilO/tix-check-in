//
//  AppDelegate.swift
//  tix
//
//  Created by Jubril on 18/11/2018.
//  Copyright © 2018 Tix. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Locksmith

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        for family in UIFont.familyNames {
            
            let sName: String = family as String
            print("family: \(sName)")
            
            for name in UIFont.fontNames(forFamilyName: sName) {
                print("name: \(name as String)")
            }
        }
        let currentCount = UserDefaults.standard.integer(forKey: "launchCount")
        print(currentCount)
        if currentCount == 0{
            let _ = try? Locksmith.deleteDataForUserAccount(userAccount: Constants.TixUser)
        }
        UserDefaults.standard.set(currentCount+1, forKey:"launchCount")
        UserDefaults.standard.synchronize()

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


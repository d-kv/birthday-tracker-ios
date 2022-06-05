//
//  AppDelegate.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 29.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let assembly = MainAssemblyImpl()
    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
    {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        // Create a view controller
        guard let myPass = KeyChainService.getKeychainData(key: "password") else {
            let viewController = AuthViewController()
                // Assign the view controller as `window`'s root view controller
            window?.rootViewController = viewController
            // Show the window
            window?.makeKeyAndVisible()
            return true
        }
        if let myLog = KeyChainService.getKeychainData(key: "login"){
            print("work")
            password = String(decoding: myPass, as: UTF8.self)
            login = String(decoding: myLog, as: UTF8.self)
            window?.rootViewController = assembly.createMainViewController()
            window?.makeKeyAndVisible()
            return true
        }
        
        
        return true
    }

    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

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
    
    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
    {
        let answer = NetworkService()
        let loginString = "\(login):\(password)"
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return false
        }
        let present = Present(id: 1, name: "Ye6eeesДААААААА", link: "http://www.vk.com/alexey.dogopolov", description: "NoneDescription", employeeId: 1)
        // let project = Project(id: 3, name: "test231", projectDescription: "JustTest")

        let base64LoginString = loginData.base64EncodedString()
        print(base64LoginString)
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.editPresent.rawValue)!,
                           method: NetworkService.Method.patch,
                           body: present,
                           headers: ["Authorization": "Basic \(base64LoginString)",
                                     "Content-Type": "application/json"],
                           completion: { result in
                               switch result {
                               case let .success(data):
                                   do {
                                       if let data = data {
                                           _ = try JSONDecoder().decode(Employee.self, from: data)
                                           print("eyeee")
                                       } else {}
                                   } catch {
                                       print("lol1")
                                   }
                                   print(String(decoding: data!, as: UTF8.self))

                               case let .failure(error):
                                   print("lol2")
                                   print(error)
                                   print(error.code)
                                   print(error.errorCode)
                                   print(error.errorUserInfo)
                                   print(error.localizedDescription)
                               }
                           })
        //Create a window that is the same size as the screen
        window = UIWindow(frame: UIScreen.main.bounds)
        // Create a view controller
        let viewController = AuthView()
        // Assign the view controller as `window`'s root view controller
        window?.rootViewController = viewController
        // Show the window
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}

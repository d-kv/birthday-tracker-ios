//
//  AppDelegate.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 29.03.2022.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
    {
        let answer = NetworkService()
        let loginString = "\(login):\(password)"
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return false
        }
        let present = Present(id: 7, name: "Ye6ee69es", link: "http://www.vk.com/alexey.dogopolov", description: "NoneDescription", employeeId: 4)
        let project = Project(id: 1, name: "test231", projectDescription: "JustTest")
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.sendProject.rawValue)!,
                           method: NetworkService.Method.patch,
                           body: project,
                           headers: ["Authorization": "Basic \(base64LoginString)"],
                           completion: { result in
                               switch result {
                               case let .success(data):
                                   do {
                                       if let data = data {
                                           _ = try JSONDecoder().decode(Profile.self, from: data)
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

        return true
    }
}

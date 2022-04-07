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
        let present = Present(id: 7, name: "Yeeees", link: "nooooo", description: "NoneDescription", employeeId: 4)
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: baseURL + Constans.sendPresent.rawValue)!,
                           method: NetworkService.Method.post,
                           params: ["employee_id": "4"],
                           body: present,
                           headers: ["Authorization": "Basic \(base64LoginString)",
                                     "Content-Type": "application/json"],
                           completion: { result in
                                  switch result {
                                  case let .success(data):
                                      do {
                                          if let data = data {
                                              let present = try JSONDecoder().decode(Present.self, from: data)
                                              print("eyeee")
                                          } else {}
                                      } catch {
                                          print("lol1")
                                      }
                                      print(String(decoding: data!, as: UTF8.self))

                                  case let .failure(error):
                                      print("lol2")
                                      print(error)
                                  }
                              })

        return true
    }
}

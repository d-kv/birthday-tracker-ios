//
//  AppDelegate.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 29.03.2022.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let answer = NetworkService()
        answer.makeRequest(for: URL(string: "http://localhost:8080/api/employee/get")!,
                              method: NetworkService.Method.get,
                              query: NetworkService.QueryType.path,
                              params: ["employee_id" : 1],
                              success: { data in
            print(String(decoding: data!, as: UTF8.self))
            if let data = data, let joke = try? JSONDecoder().decode(Employee.self, from: data) {
                print(joke.birthday)
            }
        },
                              failure: {data, error, responseCode in
            print(error,"\n", responseCode)
        })
        
        return true
    }
}

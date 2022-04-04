//
//  AppDelegate.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 29.03.2022.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let authentification = Auth(username: "test1234", password: "test123", fullName: "Lexaex Lexa Lex", phone: "+79818904325", birthday: "2001-02-02", startWork: "2020-08-08", city: "Gorkiy")
        let answer = NetworkService()
        answer.makeRequest(for: URL(string: "http://localhost:8080/auth/register")!,
                              method:NetworkService.Method.post,
                              query: NetworkService.QueryType.json,
                              params: ["username": authentification.username,
                                       "password":authentification.password,
                                       "full_name": authentification.fullName,
                                       "phone": authentification.phone,
                                       "birthday": authentification.birthday,
                                       "start_work": authentification.startWork,
                                       "city": authentification.city],
                              headers: ["Content-Type": "application/json"],
                              success: { data in
            print(String(decoding: data!, as: UTF8.self))
            if let data = data, let auth = try? JSONDecoder().decode(Auth.self, from: data) {
                print(auth.city)
            }
        }, failure: { data, error, responseCode in
            print(String(decoding: data!, as: UTF8.self), data!, "\n", error ?? "none","\n", responseCode)
        })
        
        return true
    }
}

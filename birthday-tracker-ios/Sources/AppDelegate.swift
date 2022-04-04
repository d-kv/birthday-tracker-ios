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
        let present = Present(id: 89, name: "PresentTest", link: "dota2.com", description: "very want", employeeId: 5)
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return false
        }
        let project = Project(id: 0, name: "Yeeeesergajn", projectDescription: "Yeseagkjernakl")
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: "http://localhost:8080/api/project/save")!,
                           method: NetworkService.Method.post,
                           query: NetworkService.QueryType.json,
                           params: ["id": project.id,
                                    "name": project.name,
                                    "description": project.projectDescription],
                           headers: ["Authorization": "Basic \(base64LoginString)",
                                     "Content-Type": "application/json"],
                           success: { data in
                               print(String(decoding: data!, as: UTF8.self))
                               if let data = data, let project = try?
                                   JSONDecoder().decode(Project.self, from: data)
                               {
                                   print(project.name)
                               }
                           },
                           failure: { data, error, responseCode in
                               print(String(decoding: data!, as: UTF8.self), data!, "\n", error ?? "none", "\n", responseCode)
                           })

        return true
    }
}

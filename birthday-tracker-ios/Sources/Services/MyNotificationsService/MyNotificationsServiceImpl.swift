//
//  UpcomingBirthdayImpl.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

class MyNotificationServiceImpl: MyNotificationService {
    func edit(employee _: Employee, completion _: () -> Void) {
    }

    func load(id: Int, completion: @escaping (Result<MyNotifications, Error>) -> Void){
        let answer = NetworkService()
        let username = "string"                         //Unfourtanetly,
        let password = "string"                         //It's only "затычка"
        let loginString = "\(username):\(password)"

        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: "/api/present/get")!,
                              method: NetworkService.Method.get,
                              query: NetworkService.QueryType.json,
                              params: ["present_id": id],
                              headers: ["Authorization": "Basic \(base64LoginString)"],
                              success: { data in
            print(String(decoding: data!, as: UTF8.self))
            if let data = data, let notifications = try? JSONDecoder().decode(MyNotifications.self, from: data) {
                completion(.success(notifications))
            }
        })
    }
}

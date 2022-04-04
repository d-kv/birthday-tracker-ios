//
//  UpcomingBirthdayImpl.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

class MyNotificationServiceImpl: MyNotificationService {
    let answer = NetworkService()
    let loginString = "\(login):\(password)"

    func edit(employee _: Employee, completion _: () -> Void) {}

    func load(id: Int, completion: @escaping (Result<MyNotifications, Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.getMyNotifications.rawValue)!,
                           method: NetworkService.Method.get,
                           query: NetworkService.QueryType.path,
                           params: ["employee_id": id],
                           headers: ["Authorization": "Basic \(base64LoginString)"],
                           success: { data in
                               print(String(decoding: data!, as: UTF8.self))
                               if let data = data, let notifications = try? JSONDecoder().decode(MyNotifications.self, from: data) {
                                   completion(.success(notifications))
                               }
                           })
    }
}

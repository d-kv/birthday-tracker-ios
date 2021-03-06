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

    // It's a woooork (Yep, Dr F. can proud of me)
    func load(id: Int, completion: @escaping (Result<MyNotifications, Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.getMyNotifications.rawValue)!,
                           method: NetworkService.Method.get,
                           query: NetworkService.QueryType.path,
                           params: ["employee_id": String(id)],
                           headers: ["Authorization": "Basic \(base64LoginString)"],
                           completion: { result in
                               switch result {
                               case let .success(data):
                                   do {
                                       if let data = data {
                                           let notifications = try JSONDecoder().decode(MyNotifications.self, from: data)
                                           completion(.success(notifications))
                                       } else {}
                                   } catch {
                                       completion(.failure(error))
                                   }
                                   print(String(decoding: data!, as: UTF8.self))

                               case let .failure(error):
                                   completion(.failure(error))
                               }
                           })
    }
}

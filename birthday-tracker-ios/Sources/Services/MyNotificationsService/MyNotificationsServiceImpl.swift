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

    func load(id: Int, completion: @escaping (Result<[MyNotifications], Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.getMyNotifications.rawValue)!,
                           method: NetworkService.Method.get,
                              query: NetworkService.QueryType.json,
                           params: ["employee_id": String(id)],
                           headers: ["Authorization": "Basic \(base64LoginString)"],
                           completion: { result in
                               switch result {
                               case let .success(data):
                                   do {
                                       if let data = data {
                                           let notifications = try JSONDecoder().decode([MyNotifications].self, from: data)
                                           completion(.success(notifications))
                                       } else {
                                           completion(.failure(NetworkServiceError(code: .emptyData)))
                                       }
                                   } catch {
                                       completion(.failure(error))
                                   }

                               case let .failure(error):
                                   completion(.failure(error))
                               }
                           })
    }
}

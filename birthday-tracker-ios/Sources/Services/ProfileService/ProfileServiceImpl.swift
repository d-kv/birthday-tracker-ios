//
//  ProfileServiceImpl.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 28.03.2022.
//

import Foundation

class ProfileServiceImpl: ProfileService {
    let answer = NetworkService()
    let loginString = "\(login):\(password)"

    func edit(employee: Employee, completion: @escaping (Result<Profile, Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.updateEmployee.rawValue)!,
                           method: NetworkService.Method.patch,
                           body: employee,
                           headers: ["Authorization": "Basic \(base64LoginString)"],
                           completion: { result in
                               switch result {
                               case let .success(data):
                                   do {
                                       if let data = data { // здесь не вернется эмплой, и что тогда?
                                           let profile = try JSONDecoder().decode(Profile.self, from: data)
                                           completion(.success(profile))
                                       } else {}
                                   } catch {
                                       completion(.failure(error))
                                   }

                               case let .failure(error):
                                   completion(.failure(error))
                               }
                           })
    }

    func load(id: Int, completion: @escaping (Result<Profile, Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.getEmployee.rawValue)!,
                           method: NetworkService.Method.get,
                           query: NetworkService.QueryType.path,
                           params: ["employee_id": String(id)],
                           headers: ["Authorization": "Basic \(base64LoginString)"],
                           completion: { result in
                               switch result {
                               case let .success(data):
                                   do {
                                       if let data = data {
                                           let profile = try JSONDecoder().decode(Profile.self, from: data)
                                           completion(.success(profile))
                                       } else {}
                                   } catch {
                                       completion(.failure(error))
                                   }

                               case let .failure(error):
                                   completion(.failure(error))
                               }
                           })
    }
}

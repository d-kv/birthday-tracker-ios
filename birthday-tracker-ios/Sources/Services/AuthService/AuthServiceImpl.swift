//
//  AuthServiceImpl.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

class AuthServiceImpl: AuthService {
    let answer = NetworkService()
    let loginString = "\(login):\(password)"

    func register(authentification: Auth, completion: @escaping (Result<Profile, Error>) -> Void) {
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.registerAuth.rawValue)!,
                           method: NetworkService.Method.post,
                           body: authentification,
                           headers: ["Content-Type": "application/json"],
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
                                   print(String(decoding: data!, as: UTF8.self))
                               case let .failure(error):
                                   completion(.failure(error))
                               }
                           })
    }

    // it's work
    func deleteRegister(username: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.deleteRegister.rawValue)!,
                           method: NetworkService.Method.delete,
                           query: NetworkService.QueryType.path,
                           params: ["username": username],
                           headers: ["Authorization": "Basic \(base64LoginString)"],
                           completion: { result in
                               switch result {
                               case let .success(data):
                                   if data != nil {
                                       completion(.success(()))
                                   } else {}
                               case let .failure(error):
                                   completion(.failure(error))
                               }
                           })
    }
}

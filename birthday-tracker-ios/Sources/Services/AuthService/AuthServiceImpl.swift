//
//  AuthServiceImpl.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

class AuthServiceImpl: AuthService {
    let answer = NetworkService()

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
}

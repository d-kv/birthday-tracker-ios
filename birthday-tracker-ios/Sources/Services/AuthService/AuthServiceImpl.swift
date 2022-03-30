//
//  AuthServiceImpl.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

class AuthServiceImpl: AuthService {
    func register(authentification: Auth, completion: @escaping (Result<Auth, Error>) -> Void) {//it doesn't work now
            let answer = NetworkService()
            answer.makeRequest(for: URL(string: baseURL + "/api/employee/get")!,
                                  method:NetworkService.Method.post,
                                  query: NetworkService.QueryType.json,
                                  params: ["username": authentification.username,
                                           "password":authentification.password,
                                           "full_name": authentification.fullName,
                                           "phone": authentification.phone,
                                           "birthday": authentification.birthday,
                                           "start_work": authentification.startWork,
                                           "city": authentification.city],
                                  success: { data in
                print(String(decoding: data!, as: UTF8.self))
                if let data = data, let auth = try? JSONDecoder().decode(Auth.self, from: data) {
                    completion(.success(auth))
                }
                })
    }
}

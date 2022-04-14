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

    func register(authentification: Auth, completion: @escaping (Result<Employee, Error>) -> Void) {
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.registerAuth.rawValue)!,
                           method: NetworkService.Method.post,
                           body: authentification,
                           headers: ["Content-Type": "application/json"],
                           completion: { result in
                               switch result {
                               case let .success(data):
                                   do {
                                       if let data = data {
                                           let profile = try JSONDecoder().decode(Employee.self, from: data)
                                           completion(.success(profile))
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
                               case .success:
                                   completion(.success(()))
                               case let .failure(error):
                                   completion(.failure(error))
                               }
                           })
    }
}

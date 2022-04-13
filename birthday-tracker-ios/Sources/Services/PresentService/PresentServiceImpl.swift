//
//  PresentServiceImpl.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

class PresentServiceImpl: PresentService {
    private
    let answer = NetworkService()
    let loginString = "\(login):\(password)"

    public
//it's work
    func edit(present: Present, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.editPresent.rawValue)!,
                           method: NetworkService.Method.patch,
                           body: present,
                           headers: ["Authorization": "Basic \(base64LoginString)",
                                     "Content-Type": "application/json"],
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

    // work only with auth
    func load(id: Int, completion: @escaping (Result<Present, Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: baseURL + Constans.getPresent.rawValue)!,
                           method: NetworkService.Method.get,
                           query: NetworkService.QueryType.json,
                           params: ["present_id": String(id)],
                           headers: ["Authorization": "Basic \(base64LoginString)"],
                           completion: { result in
                               switch result {
                               case let .success(data):
                                   do {
                                       if let data = data {
                                           let present = try JSONDecoder().decode(Present.self, from: data)
                                           completion(.success(present))
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

    // work only with admin auth
    func send(present: Present, completion: @escaping (Result<Present, Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.sendPresent.rawValue)!,
                           method: NetworkService.Method.post,
                           params: ["employee_id": String(present.employeeId)],
                           body: present,
                           headers: ["Authorization": "Basic \(base64LoginString)",
                                     "Content-Type": "application/json"],
                           completion: { result in
                               switch result {
                               case let .success(data):
                                   do {
                                       if let data = data {
                                           let present = try JSONDecoder().decode(Present.self, from: data)
                                           completion(.success(present))
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
    func deletePresent(present: Present, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.deletePresent.rawValue)!,
                           method: NetworkService.Method.delete,
                           body: present,
                           headers: ["Authorization": "Basic \(base64LoginString)", "Content-Type": "application/json"],
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

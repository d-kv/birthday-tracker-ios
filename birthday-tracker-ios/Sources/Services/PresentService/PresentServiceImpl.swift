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
    func edit(present: Present, completion: @escaping (Result<Present, Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.editPresent.rawValue)!,
                           method: NetworkService.Method.patch,
                           query: NetworkService.QueryType.json,
                           params: ["id": present.id,
                                    "name": present.name,
                                    "link": present.link,
                                    "description": present.description,
                                    "employee_id": present.employeeId],
                           headers: ["Authorization": "Basic \(base64LoginString)",
                                     "Content-Type": "application/json"],
                           success: { data in
                               print(String(decoding: data!, as: UTF8.self))
                               if let data = data, let present = try? // Что делать, если сервак не должен ничего ретюрнить?
                                   JSONDecoder().decode(Present.self, from: data)
                               {
                                   completion(.success(present))
                               }
                           })
    }

    func load(id: Int, completion: @escaping (Result<Present, Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: baseURL + Constans.getPresent.rawValue)!,
                           method: NetworkService.Method.get,
                           query: NetworkService.QueryType.path,
                           params: ["present_id": id],
                           headers: ["Authorization": "Basic \(base64LoginString)"],
                           success: { data in
                               print(String(decoding: data!, as: UTF8.self))
                               if let data = data, let present = try?
                                   JSONDecoder().decode(Present.self, from: data)
                               {
                                   completion(.success(present))
                               }
                           })
    }

    func send(present: Present, completion: @escaping (Result<Present, Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: baseURL + Constans.sendPresent.rawValue)!,
                           method: NetworkService.Method.post,
                           query: NetworkService.QueryType.json,
                           params: ["id": present.id, // Необходимо передать в параметры еще "employee_id"
                                    "name": present.name, // А вот как это сделать - я хз
                                    "link": present.link,
                                    "description": present.description,
                                    "employee_id": present.employeeId],
                           headers: ["Authorization": "Basic \(base64LoginString)",
                                     "Content-Type": "application/json"],
                           success: { data in
                               print(String(decoding: data!, as: UTF8.self))
                               if let data = data, let present = try?
                                   JSONDecoder().decode(Present.self, from: data)
                               {
                                   completion(.success(present))
                               }
                           })
    }
}

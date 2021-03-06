//
//  WishlistServiceImpl.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

class EmployeeServiceImpl: EmployeeService {
    let answer = NetworkService()
    let loginString = "\(login):\(password)"


    func edit(employee: Employee, completion: @escaping (Result<Void, Error>) -> Void) { guard let loginData = loginString.data(using: String.Encoding.utf8) else {
        return
    }
    let base64LoginString = loginData.base64EncodedString()
    answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.updateEmployee.rawValue)!,
                       method: NetworkService.Method.patch,
                       body: employee,
                       headers: ["Authorization": "Basic \(base64LoginString)",
                                 "Content-Type": "application/json"],
                       completion: { result in
                           switch result {
                           case let .success(data):
                               do {
                                   if let data = data { // здесь не вернется эмплой, и
                                       completion(.success(()))
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

    func load(id: Int, completion: @escaping (Result<Employee, Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.getEmployee.rawValue)!,
                           method: NetworkService.Method.get,
                           query: NetworkService.QueryType.json,
                           params: ["employee_id": String(id)],
                           headers: ["Authorization": "Basic \(base64LoginString)"],
                           completion: { result in
                               switch result {
                               case let .success(data):
                                   do {
                                       if let data = data {
                                           let present = try JSONDecoder().decode(Employee.self, from: data)
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
}

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

    // как передать правильно Эмплоя сюда? может есть способ вместо тупого вписывания просто вставить сразу экземпляр?
    func edit(employee _: Employee, completion _: @escaping (Result<Employee, Error>) -> Void) {
//        let answer = NetworkService()
//        let loginString = "\(login):\(password)"
//
//        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
//            return
//        }
//        let base64LoginString = loginData.base64EncodedString()
//        answer.makeRequest(for: URL(string: baseURL + "/api/employee/get")!,
//                              method: NetworkService.Method.get,
//                              query: NetworkService.QueryType.path,
//                              params: ["employee_id" : 1],
//                              headers: ["Authorization": "Basic \(base64LoginString)",
//                                        "Content-type": "application/json"],
//                              success: { data in
//            if let data = data, let employee = try? JSONDecoder().decode(Employee.self, from: data) {
//                completion(.success(employee))
//            }
//        })
    }

    func load(id _: Int, completion: @escaping (Result<Employee, Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.getEmployee.rawValue)!,
                           method: NetworkService.Method.get,
                           query: NetworkService.QueryType.path,
                           params: ["employee_id": 1],
                           headers: ["Authorization": "Basic \(base64LoginString)"],
                           success: { data in
                               if let data = data, let employee = try? JSONDecoder().decode(Employee.self, from: data) {
                                   completion(.success(employee))
                               }
                           })
    }

    func send(request _: URLRequest, completion _: () -> Void) {}
}

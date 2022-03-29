//
//  WishlistServiceImpl.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

class EmployeeServiceImpl: EmployeeService {
    func edit(employee _: Employee, completion _: () -> Void) {}

    func load(id: Int, completion: @escaping (Result<Employee, Error>) -> Void){
        let answer = NetworkService()
        answer.makeRequest(for: URL(string: "/api/employee/get")!, method: NetworkService.Method.get, query: NetworkService.QueryType.json,params: ["employee_id": id], success: { data in
            print(String(decoding: data!, as: UTF8.self))
            if let data = data, let employee = try? JSONDecoder().decode(Employee.self, from: data) {
                completion(.success(employee))
            }
        })
        
    }

    func send(request _: URLRequest, completion _: () -> Void) {}
}

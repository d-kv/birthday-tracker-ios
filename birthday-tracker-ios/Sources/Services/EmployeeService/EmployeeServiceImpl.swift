//
//  WishlistServiceImpl.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

class EmployeeServiceImpl: EmployeeService {
    func edit(employee _: Employee, completion _: () -> Void) {
        <#code#>
    }

    func load(id: Int, completion _: () -> Void) -> Employee{
        let answer = NetworkService()
        var employeeReturn: Employee
        answer.makeRequest(for: URL(string: "/api/employee/get")!, method: NetworkService.Method.get, query: NetworkService.QueryType.json,params: ["employee_id": id], success: { data in
            print(String(decoding: data!, as: UTF8.self))
            if let data = data, let employee = try? JSONDecoder().decode(Employee.self, from: data) {
                employeeReturn = employee
            }
        })
        return employeeReturn
        
    }

    func send(request _: URLRequest, completion _: () -> Void) {
        <#code#>
    }
}

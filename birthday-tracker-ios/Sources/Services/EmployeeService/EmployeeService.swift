//
//  EmployeeService.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

protocol EmployeeService {
    func edit(employee: Employee, completion: () -> Void)
    func load(id: Int, completion: () -> Void)
    func send(request: URLRequest, completion: () -> Void)
}

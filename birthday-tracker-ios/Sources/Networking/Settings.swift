//
//  File.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 30.03.2022.
//

import Foundation

let password = "admin"
let login = "admin"
let baseURL = "http://localhost:8080"

enum Constans: String {
    case baseURL = "http://localhost:8080"
    case registerAuth = "/auth/register"
    case getProject = "/api/project/get"
    case sendPresent = "/api/present/save"
    case editPresent = "/api/present/update"
    case getPresent = "/api/present/get"
    case getMyNotifications = "/api/employee/getMyNotifications"
    case getEmployee = "/api/employee/get"
    case updateEmployee = "/api/employee/update"
    case updateProject = "/api/project/update"
    case sendProject = "/api/project/save"
    case addEmployee = "/api/project/addEmployee"
}

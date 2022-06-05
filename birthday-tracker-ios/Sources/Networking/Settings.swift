//
//  File.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 30.03.2022.
//

import Foundation

var password: String = "admin"
var login: String = "admin"

let baseURL = "http://localhost:8080"

enum Constans: String {
    case baseURL = "http://localhost:8080"
    // Auth api
    case registerAuth = "/auth/register"
    case deleteRegister = "/auth/delete"
    // project api
    case getProject = "/api/project/get"
    case updateProject = "/api/project/update"
    case sendProject = "/api/project/save"
    case addEmployee = "/api/project/addEmployee"
    case deleteProject = "/api/project/delete"
    // present API
    case sendPresent = "/api/present/save"
    case editPresent = "/api/present/update"
    case getPresent = "/api/present/get"
    case deletePresent = "/api/present/delete"
    // employee api
    case getMyNotifications = "/api/employee/getMyNotifications"
    case getEmployee = "/api/employee/get"
    case updateEmployee = "/api/employee/update"
}

let meId = 1

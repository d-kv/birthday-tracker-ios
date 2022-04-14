//
//  ProjectService.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 30.03.2022.
//

import Foundation

protocol ProjectService {
    func load(project_id: Int, completion: @escaping (Result<Project, Error>) -> Void)
    func send(project: Project, completion: @escaping (Result<Project, Error>) -> Void)
    func update(project: Project, completion: @escaping (Result<Void, Error>) -> Void)
    func addEmployee(project_id: Int, employee_Id: Int, completion: @escaping (Result<Void, Error>) -> Void)
    func deleteProject(project: Project, completion: @escaping (Result<Void, Error>) -> Void)
}

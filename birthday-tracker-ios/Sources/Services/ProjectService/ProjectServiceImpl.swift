//
//  ProjectServiceImpl.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 30.03.2022.
//

import Foundation
// достаток прав на проект
class ProjectServiceImpl: ProjectService {
    let answer = NetworkService()
    let loginString = "\(login):\(password)"

    func send(project: Project, completion: @escaping (Result<Project, Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.sendProject.rawValue)!,
                           method: NetworkService.Method.post,
                           body: project,
                           headers: ["Authorization": "Basic \(base64LoginString)",
                                     "Content-Type": "application/json"],
                           completion: { result in
                               switch result {
                               case let .success(data):
                                   do {
                                       if let data = data {
                                           let project = try JSONDecoder().decode(Project.self, from: data)
                                           completion(.success(project))
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

    // тут ничего не возвращается, а ну впринципе и не работает)
    func update(project: Project, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.updateProject.rawValue)!,
                           method: NetworkService.Method.patch,
                           body: project,
                           headers: ["Authorization": "Basic \(base64LoginString)"],
                           completion: { result in
                               switch result {
                               case let .success(data):
                                   completion(.success(()))
                                   print(String(decoding: data!, as: UTF8.self))
                               case let .failure(error):
                                   completion(.failure(error))
                               }
                           })
    }

    func addEmployee(project_id: Int, employee_Id: Int, completion: @escaping (Result<Project, Error>) -> Void) {
        let answer = NetworkService()
        let loginString = "\(login):\(password)"

        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.addEmployee.rawValue)!,
                           method: NetworkService.Method.post,
                           query: NetworkService.QueryType.path,
                           params: ["employee_id": String(employee_Id),
                                    "project_id": String(project_id)],
                           headers: ["Authorization": "Basic \(base64LoginString)"],
                           completion: { result in
                               switch result {
                               case let .success(data):
                                   do {
                                       if let data = data {
                                           let project = try JSONDecoder().decode(Project.self, from: data)
                                           completion(.success(project))
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

    func load(project_id: Int, completion: @escaping (Result<Project, Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.getProject.rawValue)!,
                           method: NetworkService.Method.get,
                           query: NetworkService.QueryType.path,
                           params: ["project_id": String(project_id)],
                           headers: ["Authorization": "Basic \(base64LoginString)"],
                           completion: { result in
                               switch result {
                               case let .success(data):
                                   do {
                                       if let data = data {
                                           let project = try JSONDecoder().decode(Project.self, from: data)
                                           completion(.success(project))
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
    //It's work
    func deleteProject(project: Project, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: Constans.baseURL.rawValue + Constans.deleteProject.rawValue)!,
                           method: NetworkService.Method.delete,
                           body: project,
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
}

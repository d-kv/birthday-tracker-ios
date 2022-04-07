//
//  ProjectServiceImpl.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 30.03.2022.
//

import Foundation
// `недостаток прав на проект
class ProjectServiceImpl: ProjectService {
    let answer = NetworkService()
    let loginString = "\(login):\(password)"

//    func send(project: Project, completion: @escaping (Result<Project, Error>) -> Void) {
//        let answer = NetworkService()
//        let loginString = "\(login):\(password)"
//
//        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
//            return
//        }
//        let base64LoginString = loginData.base64EncodedString()
//        answer.makeRequest(for: URL(string: baseURL + "api/project/save")!,
//                              method: NetworkService.Method.post,
//                              query: NetworkService.QueryType.json,
//                              params: ["project_id": project.id,
//                                       "name": project.name,
//                                       "description": project.projectDescription],
//                              headers: ["Authorization": "Basic \(base64LoginString)",
//                                        "Content-Type": "application/json"],
//                              success: { data in
//            print(String(decoding: data!, as: UTF8.self))
//            if let data = data, let project = try? JSONDecoder().decode(Project.self, from: data) {
//                completion(.success(project))
//            }
//        })
//    }
//
//    func update(project: Project, completion: @escaping (Result<Project, Error>) -> Void) {
//
//    }
//
//    func addEmployee(project_id: Int, employee_Id: Int, completion: @escaping (Result<Project, Error>) -> Void) {
//
//    }
//
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
//
}

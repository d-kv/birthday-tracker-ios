//
//  ProjectServiceImpl.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 30.03.2022.
//

import Foundation

class ProjectServiceImpl: ProjectService{
    func load(project_id: Int, completion: @escaping (Result<Project, Error>) -> Void) {
        let answer = NetworkService()
        let loginString = "\(login):\(password)"

        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: "http://localhost:8080/api/project/get")!,
                              method: NetworkService.Method.get,
                              query: NetworkService.QueryType.path,
                              params: ["project_id": project_id],
                              headers: ["Authorization": "Basic \(base64LoginString)"],
                              success: { data in
            print(String(decoding: data!, as: UTF8.self))
            if let data = data, let project = try? JSONDecoder().decode(Project.self, from: data) {
                completion(.success(project))
            }
        })
    }
    
    
}

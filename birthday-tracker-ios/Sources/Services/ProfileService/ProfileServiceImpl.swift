//
//  ProfileServiceImpl.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 28.03.2022.
//

import Foundation

class ProfileServiceImpl: ProfileService {

    func edit(employee _: Employee, completion _: () -> Void) {
    }

    func load(id: Int, completion: @escaping (Result<Profile, Error>) -> Void) {
        let answer = NetworkService()
        answer.makeRequest(for: URL(string: "/api/employee/get")!, method: NetworkService.Method.get, query: NetworkService.QueryType.json,params: ["employee_id": id], success: { data in
            print(String(decoding: data!, as: UTF8.self))
            if let data = data, let employee = try? JSONDecoder().decode(Profile.self, from: data) {
                completion(.success(employee))
            }
        })
    }

    func send(request _: URLRequest, completion _: () -> Void) {
    }
}

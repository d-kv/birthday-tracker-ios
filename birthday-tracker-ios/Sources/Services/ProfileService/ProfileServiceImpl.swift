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
        let username = "string"                         //Unfourtanetly,
        let password = "string"                         //It's only "затычка"
        let loginString = "\(username):\(password)"

        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        answer.makeRequest(for: URL(string: "/api/employee/get")!,
                              method: NetworkService.Method.get,
                              query: NetworkService.QueryType.json,
                              params: ["employee_id": id],
                              headers: ["Authorization": "Basic \(base64LoginString)"],
                              success: { data in
            print(String(decoding: data!, as: UTF8.self))
            if let data = data, let employee = try? JSONDecoder().decode(Profile.self, from: data) {
                completion(.success(employee))
            }
        })
    }

    func send(request _: URLRequest, completion _: () -> Void) {
    }
}

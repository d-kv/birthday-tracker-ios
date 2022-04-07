//
//  ProfileService.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 28.03.2022.
//

import Foundation

protocol ProfileService {
    func edit(employee: Employee, completion: () -> Void)
    func load(id: Int, completion: @escaping (Result<Profile, Error>) -> Void)
    func send(request: URLRequest, completion: () -> Void)
}

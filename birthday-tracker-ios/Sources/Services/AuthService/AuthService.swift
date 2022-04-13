//
//  AuthService.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

protocol AuthService {
    func register(authentification: Auth, completion: @escaping (Result<Profile, Error>) -> Void)
    func deleteRegister(username: String, completion: @escaping (Result<Void, Error>) -> Void)
}

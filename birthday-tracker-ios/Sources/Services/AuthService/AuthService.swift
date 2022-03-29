//
//  AuthService.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

protocol AuthService {
    func register(authentification: Auth, completion: @escaping (Result<Auth, Error>) -> Void)
}

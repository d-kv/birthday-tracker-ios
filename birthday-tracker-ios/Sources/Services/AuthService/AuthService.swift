//
//  AuthService.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

protocol AuthService {
    func load(id: Int, completion: () -> Void)
}

//
//  PresentService.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

protocol PresentService {
    func edit(present: Present, completion: @escaping (Result<Void, Error>) -> Void)

    func load(id: Int, completion: @escaping (Result<Present, Error>) -> Void)

    func send(present: Present, completion: @escaping (Result<Present, Error>) -> Void)

    func deletePresent(present: Present, completion: @escaping (Result<Void, Error>) -> Void)
}

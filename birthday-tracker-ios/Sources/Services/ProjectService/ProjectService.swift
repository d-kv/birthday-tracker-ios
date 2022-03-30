//
//  ProjectService.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 30.03.2022.
//

import Foundation

protocol ProjectService {
    func load(project_id: Int, completion: @escaping (Result<Project, Error>) -> Void)
}

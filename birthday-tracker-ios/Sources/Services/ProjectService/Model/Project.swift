//
//  Project.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 29.03.2022.
//

import Foundation

struct Project: Codable {
    let id: Int
    let name, projectDescription: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case projectDescription = "description"
    }
}

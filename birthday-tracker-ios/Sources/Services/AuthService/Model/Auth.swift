//
//  Auth.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

struct Auth: Codable {
    let username, password, fullName, phone: String
    let birthday, startWork, city: String

    enum CodingKeys: String, CodingKey {
        case username, password
        case fullName = "full_name"
        case phone, birthday
        case startWork = "start_work"
        case city
    }
}

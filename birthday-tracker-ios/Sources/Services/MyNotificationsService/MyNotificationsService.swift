//
//  UpcomingBirthdayService.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

protocol MyNotificationService {
    func edit(employee: Employee, completion: () -> Void)
    func load(id: Int, completion: () -> Void)
}

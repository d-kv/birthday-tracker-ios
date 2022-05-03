//
//  WishlistPresenter.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

protocol WishlistPresenter: AnyObject {
}

class WishlistPresenterImpl: WishlistPresenter {
    private let service: EmployeeService
    weak var view: MyNotificationsViewController?

    init(service: EmployeeService) {
        self.service = service
    }

    func viewWillAppear() {}
}

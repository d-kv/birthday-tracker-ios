//
//  EmployeePresenter.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

protocol EmployeePresenter: AnyObject {
}

class EmployeePresenterImpl: EmployeePresenter {
    private let service: EmployeeService
    weak var view: EmployeeViewController?

    init(service: EmployeeService) {
        self.service = service
    }

    func viewWillAppear() {}
}

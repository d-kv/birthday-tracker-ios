//
//  PresentPresenter.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

protocol PresentPresenter: AnyObject {
}

class PresentPresenterImpl: PresentPresenter {
    private let service: EmployeeService
    weak var view: PresentViewController?

    init(service: EmployeeService) {
        self.service = service
    }

    func viewWillAppear() {}
}

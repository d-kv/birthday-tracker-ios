//
//  AuthPresenter.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

protocol AuthPresenter: AnyObject {
    func auth(login: String, password: String)
}

class AuthPresenterImpl: AuthPresenter {
    private let service: EmployeeService
    weak var view: AuthViewController?

    init(service: EmployeeService) {
        self.service = service
    }

    func viewWillAppear() {}

    func auth(login _: String, password _: String) {
        service.load(id: 1) { [weak self] result in
            switch result {
            case let .failure(error):
                self?.view?.showError(error)
            case .success:
                print("LOL")
                self?.view?.handleSuccess()
            }
        }
    }
}

//
//  AuthPresenter.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

protocol AuthView {
    func showError(_ error: Error)
    func handleSuccess()
}

protocol AuthPresenter: AnyObject {
    func auth(login: String, password: String)
}

class AuthPresenterImpl {
    
    private let service: EmployeeService
    weak var view: AuthView?
    
    init(service: EmployeeService) {
        self.service = service
    }
    
    func viewWillAppear() {}
    func auth(login: String, password: String) {
        service.load(id: 1) { [weak self] result in
            switch result {
            case let .failure(error):
                self?.view?.showError(error)
            case .success:
                self?.view?.handleSuccess()
            }
        }
    }
    
}

//
//  ProfilePresenter.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 28.03.2022.
//

import Foundation

protocol ProfilePresenter: AnyObject {
}

class ProfilePresenterImpl: ProfilePresenter {
    private let service: EmployeeService
    weak var view: ProfileViewController?

    init(service: EmployeeService) {
        self.service = service
    }

    func getProfile(myEmployee: Int){
        service.load(id: myEmployee, completion:  {[weak self] result in
                     switch result {
                     case let .failure(error):
                         self?.view?.showError(error)
                     case .success(let employee):
                         self?.view?.handleSuccess(profile: employee)
                     }
        })
    }
    func viewWillAppear() {}
}

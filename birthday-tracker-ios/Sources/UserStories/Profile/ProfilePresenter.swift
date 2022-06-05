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
    weak var updateView: ProfileUpdateViewController?

    init(service: EmployeeService) {
        self.service = service
    }

    func getProfile(myEmployee: Int){
        service.load(id: myEmployee, completion:  {[weak self] result in
                     switch result {
                     case let .failure(error):
                         self?.view?.showError(error)
                         print(result)
                     case .success(let employee):
                         self?.view?.handleSuccess(profile: employee)
                     }
        })
    }
    
    func update(myEmployee: Employee){
        service.edit(employee: myEmployee, completion:  {[weak self] result in
                     switch result {
                     case let .failure(error):
                         self?.updateView?.showError(error: error)
                     case .success():
                         self?.updateView?.handleSuccess()
                     }
        })
    }
    func viewWillAppear() {}
}

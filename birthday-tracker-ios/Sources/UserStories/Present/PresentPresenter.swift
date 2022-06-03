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
    private let service: PresentService
    weak var view: AddPresentViewController?

    init(service: PresentService) {
        self.service = service
    }

    func viewWillAppear() {}
    
    func getProfile(present: Present){
        service.send(present: present, completion:  {[weak self] result in
                     switch result {
                     case let .failure(error):
                         self?.view?.showError(error)
                     case .success(_):
                         self?.view?.handleSuccess()
                     }
        })
    }
}

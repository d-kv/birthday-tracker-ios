//
//  MyNotificationsPresenter.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

protocol MyNotificationPresenter: AnyObject {
}

class MyNotificationPresenterImpl: MyNotificationPresenter {
    private let service: MyNotificationServiceImpl
    
    weak var view: MyNotificationsViewController?

    init(service: MyNotificationServiceImpl) {
        self.service = service
    }
    
    func getNotifications(id: Int){
        service.load(id: id, completion: {[weak self] result in
            switch result {
            case let .failure(error):
                print(error.localizedDescription)
                print(result)
                self?.view?.showError(error)
            case .success(let notifications):
                self?.view?.handleSuccess(notifications: notifications)
            }
})
    }

    func viewWillAppear() {}
}


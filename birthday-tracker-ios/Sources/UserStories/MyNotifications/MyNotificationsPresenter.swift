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

    func viewWillAppear() {}
}


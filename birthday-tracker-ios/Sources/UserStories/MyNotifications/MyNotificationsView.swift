//
//  MyNotificationsView.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import UIKit

protocol MyNotificationsView {
    func showError(_ error: Error)
    func handleSuccess()
}

class MyNotificationsViewController: UIViewController, MyNotificationsView {
    func showError(_ error: Error) {
        
    }
    
    func handleSuccess() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    }
}

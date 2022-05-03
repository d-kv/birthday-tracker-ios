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
    let table = UITableView()
    let presenter = MyNotificationPresenterImpl(service: MyNotificationServiceImpl())
    
    func showError(_ error: Error) {
        
    }
    
    func handleSuccess() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        view.backgroundColor = .darkGray
        navigationItem.title = "Ближайшие дни рождения"
        navigationController?.navigationBar.tintColor = .white
        
        view.addSubview(table)
        
    }
}

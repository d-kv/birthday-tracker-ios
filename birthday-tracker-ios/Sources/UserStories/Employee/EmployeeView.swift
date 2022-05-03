//
//  EmployeeView.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import UIKit

protocol EmployeeView {
    func showError(_ error: Error)
    func handleSuccess()
}

class EmployeeViewController: UIViewController, ProfileView {
    func handleSuccess(profile: Employee) {
        
    }
    
    func showError(_ error: Error) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
    }
    
}

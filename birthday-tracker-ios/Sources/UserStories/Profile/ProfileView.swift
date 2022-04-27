//
//  ProfileView.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 28.03.2022.
//

import UIKit

protocol ProfileView {
    func showError(_ error: Error)
    func handleSuccess()
}

class ProfileViewController: UIViewController, ProfileView {
    func showError(_ error: Error) {
        
    }
    
    func handleSuccess() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
    }
    
}

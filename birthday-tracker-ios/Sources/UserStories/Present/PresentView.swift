//
//  PresentView.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import SwiftUI

protocol PresentView {
    func showError(_ error: Error)
    func handleSuccess()
}

class PresentViewController: UIViewController, PresentView {
    func showError(_ error: Error) {
        
    }
    
    func handleSuccess() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
    }
    
}

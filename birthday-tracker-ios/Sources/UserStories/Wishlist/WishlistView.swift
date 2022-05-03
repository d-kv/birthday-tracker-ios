//
//  WishlistView.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import UIKit

protocol WishlistView {
    func showError(_ error: Error)
    func handleSuccess()
}

class WishlistViewController: UIViewController, WishlistView {
    func showError(_ error: Error) {
        
    }
    
    func handleSuccess() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
    }
    
}

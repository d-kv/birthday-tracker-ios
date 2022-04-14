//
//  AuthView.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import UIKit
import SwiftUI

class AuthView: UIViewController {
    var loginButton: UIButton!
    var nameTextField: UITextField!
    var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        
        loginButton = UIButton(type: .system)
        loginButton.frame.size = CGSize(width: 200, height: 20)
        loginButton.setTitle("Вход", for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.tintColor = .black
        loginButton.backgroundColor = .yellow
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(handleLoginTouchUpInside), for: .touchUpInside)
        
        nameTextField = UITextField(frame: .zero)
        nameTextField.placeholder = "Логин"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)

        passwordTextField = UITextField(frame: .zero)
        passwordTextField.placeholder = "Пароль"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        limitedsInit()
    }
    
    func limitedsInit () {
        NSLayoutConstraint.activate ([
          loginButton.centerXAnchor.constraint (equalTo: view.centerXAnchor),
          loginButton.centerYAnchor.constraint (equalTo: view.centerYAnchor, constant: 60),
          
          passwordTextField.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
          passwordTextField.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 20),
          passwordTextField.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -20),

          nameTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -40),
          nameTextField.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 20),
          nameTextField.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func handleLoginTouchUpInside() {
        print("Login has been tapped")
        login = nameTextField.text!
        password = passwordTextField.text!
        let test = PresentServiceImpl()
        test.load(id: 1,
                  completion: { print($0)}
        )
    }}


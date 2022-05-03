//
//  AuthView.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import UIKit

protocol AuthView {
    func showError(_ error: Error)
    func handleSuccess()
}

class AuthViewController: UIViewController, AuthView {
    let assembly = MainAssemblyImpl()
    var presenter = AuthPresenterImpl(service: EmployeeServiceImpl())

    func showError(_ error: Error) {
        print(error)
    }

    func handleSuccess() {
        let vc = assembly.createMainViewController()
        present(vc, animated: true)
    }

    var loginButton: UIButton!
    var nameTextField: UITextField!
    var passwordTextField: UITextField!
    var viewLogo = UIImageView(image: UIImage(named: "tink"))
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        view.backgroundColor = .black
        

        loginButton = UIButton(type: .system)
        loginButton.frame.size = CGSize(width: 200, height: 20)
        loginButton.setTitle("Вход", for: .normal)
        loginButton.tintColor = .black
        loginButton.backgroundColor = .yellow
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(handleLoginTouchUpInside), for: .touchUpInside)

        nameTextField = UITextField(frame: .zero)
        nameTextField.placeholder = "Логин"
        nameTextField.borderStyle = .roundedRect

        passwordTextField = UITextField(frame: .zero)
        passwordTextField.placeholder = "Пароль"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect

        addSubviewsTurnOnConstraints(view: view, elements: [viewLogo, loginButton,
                                                            nameTextField, passwordTextField])
        limitedsInit()
    }

    func limitedsInit() { 
        NSLayoutConstraint.activate([
            
            viewLogo.widthAnchor.constraint(equalTo: view.widthAnchor),
            viewLogo.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -viewLogo.frame.size.width/10),
            viewLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -viewLogo.frame.height/3.5),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60),
            loginButton.widthAnchor.constraint(equalToConstant: CGFloat(200)),

            passwordTextField.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -20),

            nameTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -40),
            nameTextField.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -20),
        ])
    }

    @objc func handleLoginTouchUpInside() {
        print("Login has been tapped")
        login = nameTextField.text!
        password = passwordTextField.text!
        presenter.auth(login: login, password: password)
    }
}

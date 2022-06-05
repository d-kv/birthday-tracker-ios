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
        drawError()
    }

    func handleSuccess() {
        let vc = assembly.createMainViewController()
        print(KeyChainService.save(key: "password", data: Data(password.utf8)))
        print(KeyChainService.save(key: "login", data: Data(login.utf8)))
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }

    var loginButton: UIButton!
    var errorLabel: UILabel!
    var nameTextField: UITextField!
    var passwordTextField: UITextField!
    var background: CAGradientLayer!
    var viewLogo = UIImageView(image: UIImage(named: "tink"))
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        background = ColorSkin.default.strategy.gradient()
        background.frame = view.bounds
        view.layer.insertSublayer(background, at: 0)

        loginButton = UIButton(type: .system)
        
        loginButton.addTarget(self, action: #selector(handleLoginTouchUpInside), for: .touchUpInside)
        loginButton.settingsUI(backgroundColor: ColorSkin.default.strategy.buttonBackgroundColor(),
                               title: "Вход",
                               titleColor: ColorSkin.default.strategy.fontColor(),
                               cornerRadius: 10)

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
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 200),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor),
            loginButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor,
                                                constant: passwordTextField.frame.height/2),

            passwordTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -30),

            nameTextField.topAnchor.constraint(equalTo: viewLogo.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 30),
            nameTextField.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -30),
        ])
    }
    
    func drawError(){
        errorLabel = UILabel()
        errorLabel.settingsUI(textAlignment: .center,
                              text: "Попробуйте ещё раз",
                              backgroundColor: ColorSkin.default.strategy.messageBackgroundColor(),
                              tintColor: ColorSkin.default.strategy.fontColor(),
                              masksToBounds: true,
                              cornerRadius: 10)
        addSubviewsTurnOnConstraints(view: view, elements: [errorLabel])
        errorConstraints()
    }
    
    func errorConstraints(){
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            errorLabel.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            errorLabel.heightAnchor.constraint(equalTo: nameTextField.heightAnchor)
        ])
    }

    @objc func handleLoginTouchUpInside() {
        login = nameTextField.text!
        password = passwordTextField.text!
        presenter.auth(login: nameTextField.text!, password: nameTextField.text!)
    }
}

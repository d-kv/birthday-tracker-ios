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

class PresentViewController: UIViewController{

    private let popUpWindowView = PopUpWindowView()
    
    init(title: String, text: String, linkText: String, buttontext: String) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        
        popUpWindowView.presentName.text = title
        popUpWindowView.descriptionText.text = "Описание: " + text
        popUpWindowView.linkText.text = "Ссылка:" + linkText
        popUpWindowView.closeButton.setTitle(buttontext, for: .normal)
        popUpWindowView.closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        view = popUpWindowView
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }

}

private class PopUpWindowView: UIView {
    
    let presentView = UIView(frame: CGRect.zero)
    let presentName = UILabel(frame: CGRect.zero)
    let linkText = UILabel(frame: CGRect.zero)
    let descriptionText = UILabel(frame: CGRect.zero)
    let closeButton = UIButton(frame: CGRect.zero)
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        presentView.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        presentView.layer.borderWidth = 2
        presentView.layer.masksToBounds = true
        presentView.layer.cornerRadius = 10
        presentView.layer.borderColor = ColorSkin.default.strategy.buttonBorderColor()
        
        presentName.adjustsFontSizeToFitWidth = true
        presentName.clipsToBounds = true
        presentName.numberOfLines = 1
        presentName.settingsUI(textAlignment: .center,
                              text: "",
                              backgroundColor: ColorSkin.default.strategy.buttonBackgroundColor(),
                              tintColor: ColorSkin.default.strategy.fontColor(),
                              masksToBounds: true,
                              cornerRadius: 10,
                              borderWidth: 2,
                              borderColor: ColorSkin.default.strategy.buttonBorderColor())
        
        
        descriptionText.textColor = ColorSkin.default.strategy.fontColor()
        descriptionText.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        descriptionText.numberOfLines = 0
        descriptionText.textAlignment = .center
        
        linkText.textColor = ColorSkin.default.strategy.fontColor()
        linkText.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        linkText.numberOfLines = 0
        linkText.textAlignment = .center
        
        closeButton.setTitleColor(ColorSkin.default.strategy.fontColor(), for: .normal)
        closeButton.backgroundColor = ColorSkin.default.strategy.messageBackgroundColor()
        
        addSubviewsTurnOnConstraints(view: presentView, elements: [presentName,
                                                                   descriptionText,
                                                                   closeButton,
                                                                   linkText])
        
        addSubviewsTurnOnConstraints(view: self, elements: [presentView])
        doConstraintsMagic()
    }
    
    func doConstraintsMagic(){
        NSLayoutConstraint.activate([
            presentView.widthAnchor.constraint(equalToConstant: 293),
            presentView.heightAnchor.constraint(equalToConstant: 529),
            presentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            presentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            presentName.leadingAnchor.constraint(equalTo: presentView.leadingAnchor,
                                                constant: 2),
            presentName.trailingAnchor.constraint(equalTo: presentView.trailingAnchor,
                                                 constant: -2),
            presentName.topAnchor.constraint(equalTo: presentView.topAnchor,
                                            constant: 2),
            presentName.heightAnchor.constraint(equalToConstant: 55),
            
            //descriptionText.heightAnchor.constraint(greaterThanOrEqualToConstant: 67),
            descriptionText.topAnchor.constraint(equalTo: presentName.bottomAnchor,
                                                 constant: 8),
            descriptionText.leadingAnchor.constraint(equalTo: presentView.leadingAnchor,
                                                     constant: 15),
            descriptionText.trailingAnchor.constraint(equalTo: presentView.trailingAnchor,
                                                      constant: -15),
            descriptionText.heightAnchor.constraint(equalToConstant: 200),
            
            linkText.topAnchor.constraint(equalTo: descriptionText.bottomAnchor),
            linkText.leadingAnchor.constraint(equalTo: presentView.leadingAnchor,
                                              constant: 15),
            linkText.trailingAnchor.constraint(equalTo: presentView.trailingAnchor,
                                               constant: -15),
            linkText.bottomAnchor.constraint(equalTo: closeButton.topAnchor,
                                             constant: -2),
            
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            closeButton.leadingAnchor.constraint(equalTo: presentView.leadingAnchor,
                                                 constant: 2),
            closeButton.trailingAnchor.constraint(equalTo: presentView.trailingAnchor,
                                                  constant: -2),
            closeButton.bottomAnchor.constraint(equalTo: presentView.bottomAnchor,
                                                constant: -2)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class AddPresentViewController: UIViewController{
    var navBar: UINavigationBar!
    var navItem: UINavigationItem!
    var backButton: UIBarButtonItem!
    var presentName = UITextField(frame: .zero)
    var presentDescription = UITextField(frame: .zero)
    var presentLink = UITextField(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        drawView()
        addSubviewsTurnOnConstraints(view: view, elements: [presentName,
                                                           presentDescription,
                                                           presentLink,
                                                           navBar])
        doConstraintMagic()
    }
    
    func drawView(){
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: view.frame.size.width, height: 44))
        navItem = UINavigationItem(title: "Добавить Подарок")
        navItem.titleView?.tintColor = ColorSkin.default.strategy.fontColor()
        backButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                         target: self,
                                       action: #selector(back))
        navItem.leftBarButtonItem = backButton
        navBar.setItems([navItem], animated: false)
        
        presentName.placeholder = "Введите название подарка"
        drawTextField(text: presentName)
        
        presentLink.placeholder = "Вставьте ссылку на подарок"
        drawTextField(text: presentLink)
        
        presentDescription.placeholder = "Введите описание подарка"
        drawTextField(text: presentDescription)
    }
    
    func drawTextField(text: UITextField){
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 10
        text.layer.borderColor = ColorSkin.default.strategy.buttonBorderColor()
        text.layer.borderWidth = 2
        text.borderStyle = .roundedRect
    }
    
    func doConstraintMagic(){
        NSLayoutConstraint.activate([
            navBar.heightAnchor.constraint(equalToConstant: 44),
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            navBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            presentName.topAnchor.constraint(equalTo: navBar.bottomAnchor,
                                             constant: navBar.frame.height*2),
            presentName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentName.widthAnchor.constraint(equalTo: view.widthAnchor,
                                               constant: -view.frame.width/3),
            
            presentDescription.topAnchor.constraint(equalTo: presentName.bottomAnchor,
                                                    constant: presentName.frame.height*3),
            presentDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentDescription.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                      constant: -view.frame.width/3),
        ])
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
}

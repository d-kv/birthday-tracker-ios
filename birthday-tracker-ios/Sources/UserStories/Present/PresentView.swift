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
                              cornerRadius: 10)
        
        
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


protocol AddPresent{
    func showError(_ error: Error)
    func handleSuccess()
}

class AddPresentViewController: UIViewController, AddPresent{
    var backButton: UIButton!
    var presentName = UITextField(frame: .zero)
    var presentDescription = UITextField(frame: .zero)
    var presentLink = UITextField(frame: .zero)
    var commitChangesButton = UIButton(type: .system)
    weak var delegate: WishlistViewController?
    let service = PresentPresenterImpl(service: PresentServiceImpl())
    var header: UILabel!
    
    func showError(_ error: Error) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func handleSuccess() {
        delegate?.draw()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        drawView()
        addSubviewsTurnOnConstraints(view: view, elements: [presentName,
                                                            presentDescription,
                                                            presentLink,
                                                            backButton,
                                                            header,
                                                            commitChangesButton])
        doConstraintMagic()
    }
    
    func drawView(){
        header = UILabel()
        header.text = "Добавить Подарок"
        header.textAlignment = .center
        header.textColor = ColorSkin.default.strategy.fontColor()
        backButton = UIButton()
        backButton.settingsUI(backgroundColor: ColorSkin.default.strategy.invisibleBackground(),
                              title: "Отменa",
                              titleColor: ColorSkin.default.strategy.fontColor(),
                              cornerRadius: 0)
        backButton.addTarget(self,
                             action: #selector(back),
                             for: .touchUpInside)
        
        presentName.settingUI(placeholder: "Введите название подарка")
        
        presentLink.settingUI(placeholder: "Вставьте ссылку на подарок")
        
        presentDescription.settingUI(placeholder: "Введите описание подарка")
        
        commitChangesButton.settingsUI(backgroundColor: ColorSkin.default.strategy.buttonBackgroundColor(),
                                       title: "Сохранить",
                                       titleColor: ColorSkin.default.strategy.fontColor(),
                                       cornerRadius: 10)
        commitChangesButton.addTarget(self, action: #selector(commitChanges), for: .touchUpInside)
    }
    
    @objc func commitChanges(){
        service.getProfile(present: Present(id: 0,
                                            name: presentName.text ?? "",
                                            link: presentLink.text ?? "",
                                            presentDescription: presentDescription.text ?? "",
                                            employeeID: meId))
        delegate?.draw()
        self.dismiss(animated: true, completion: nil)
    }
    
    func doConstraintMagic(){
        NSLayoutConstraint.activate([
            header.heightAnchor.constraint(equalToConstant: 44),
            header.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            header.widthAnchor.constraint(equalTo: view.widthAnchor),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            backButton.topAnchor.constraint(equalTo: view.topAnchor,
                                           constant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            
            
            presentName.topAnchor.constraint(equalTo: view.topAnchor,
                                             constant: 200),
            presentName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentName.widthAnchor.constraint(equalTo: view.widthAnchor,
                                               constant: -40),
            
            presentDescription.topAnchor.constraint(equalTo: presentName.bottomAnchor,
                                                    constant: 40),
            presentDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentDescription.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                      constant: -40),
            
            presentLink.topAnchor.constraint(equalTo: presentDescription.bottomAnchor,
                                             constant: 40),
            presentLink.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentLink.widthAnchor.constraint(equalTo: view.widthAnchor,
                                               constant: -40),
            
            commitChangesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            commitChangesButton.topAnchor.constraint(equalTo: presentLink.bottomAnchor,
                                                     constant: 100),
            commitChangesButton.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                       constant: -150),
            commitChangesButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
}

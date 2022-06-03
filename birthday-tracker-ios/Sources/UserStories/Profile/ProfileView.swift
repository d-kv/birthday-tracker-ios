//
//  ProfileView.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 28.03.2022.
//

import UIKit
//надо настроить размер cell

protocol ProfileView {
    func showError(_ error: Error)
    func handleSuccess(profile: Employee)
}

protocol ColorShifter{
    func changeColorView()
}

class ProfileViewController: UIViewController, ColorShifter {
    var delegate: ColorShifter?
    var delegateTabBar: ColorShifter?
    var delegateNotification: ColorShifter?
    let assembly = WishlistAssemblyImpl()
    let fullNameLabel = UILabel()
    var picture = UIImageView(image: UIImage(named: "Trollface"))
    let infoTable = UITableView()
    let presenter = ProfilePresenterImpl(service: EmployeeServiceImpl())
    var profileInfo = [String]()
    let wishlistButton = UIButton(type: .system)
    let simpleTableIdentifier = "SimpleTableIdentifier"
    var updateButton = UIButton(type: .system)
    var profileInfoTitle = [String]()
    let swithTheme = UISwitch()
    var myProfile: Employee!
    var background: CAGradientLayer!
    var header: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        background = ColorSkin.default.strategy.gradient()
        background.frame = view.bounds
        view.layer.insertSublayer(background, at: 0)
        presenter.getProfile(myEmployee: meId)
    }
    
    
    func drawProfile(profile: Employee){
        header = UILabel()
        header.text = "Профиль"
        header.textAlignment = .center
        header.textColor = ColorSkin.default.strategy.fontColor()
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        profileInfo = [profile.phone, profile.city, profile.birthday, profile.startWork,   "\(profile.projects.count)"]
        profileInfoTitle = ["Связаться:", "Город:", "ДР:", "Начало работы:", "Кол-во проектов:"]
                            
        infoTable.backgroundColor = ColorSkin.default.strategy.invisibleBackground()
        
        wishlistButton.settingsUI(backgroundColor: ColorSkin.default.strategy.buttonBackgroundColor(),
                                  title: "Список пожеланий",
                                  titleColor: ColorSkin.default.strategy.fontColor(),
                                  cornerRadius: 10)
        wishlistButton.addTarget(self, action: #selector(handleWishlistTouchUpInside), for: .touchUpInside)
        
        picture.backgroundColor = .white
        picture.layer.cornerRadius = 45
        picture.layer.borderWidth = 2
        picture.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        fullNameLabel.settingsUI(textAlignment: .center,
                          text: profile.fullName,
                          backgroundColor: ColorSkin.default.strategy.invisibleBackground(),
                          tintColor: ColorSkin.default.strategy.fontColor(),
                          masksToBounds: false,
                          cornerRadius: 0)
        
        infoTable.register(UITableViewCell.self, forCellReuseIdentifier: "SimpleTableIdentifier")
        infoTable.dataSource = self
        infoTable.delegate = self
        infoTable.reloadData()
        
        
        updateButton.settingsUI(backgroundColor: ColorSkin.default.strategy.buttonBackgroundColor(),
                                title: "Редактировать",
                                titleColor: ColorSkin.default.strategy.fontColor(),
                                cornerRadius: 10)
        updateButton.addTarget(self, action: #selector(handleUpdateTouchUpInside), for: .touchUpInside)
        
        
        swithTheme.addTarget(self, action: #selector(self.switchStateDidChange(_:)), for: .valueChanged)
        swithTheme.setOn(true, animated: false)
        swithTheme.onTintColor = ColorSkin.default.strategy.buttonBackgroundColor()
        addSubviewsTurnOnConstraints(view: view,
                                     elements: [fullNameLabel, picture,
                                                infoTable, wishlistButton,
                                                updateButton, swithTheme,
                                               header])
        doConstraintsMagic()
    }
    
    
    func doConstraintsMagic(){
        NSLayoutConstraint.activate([
            header.heightAnchor.constraint(equalToConstant: 44),
            header.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            header.widthAnchor.constraint(equalTo: view.widthAnchor),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            swithTheme.topAnchor.constraint(equalTo: view.topAnchor,
                                            constant: view.frame.height/10),
            swithTheme.rightAnchor.constraint(equalTo: view.rightAnchor,
                                              constant: -view.frame.width/15),
            //trollface constraints
            picture.widthAnchor.constraint(equalTo: view.widthAnchor,
                                           constant: -view.frame.width*6/10),
            picture.heightAnchor.constraint(equalTo: view.widthAnchor,
                                            constant: -view.frame.width*6/10),
            picture.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                             constant: -view.frame.width*2/3),
            picture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            fullNameLabel.topAnchor.constraint(equalTo: picture.bottomAnchor,
                                        constant: view.frame.height/40),
            fullNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor,
                                          constant: -view.frame.width/5),
            fullNameLabel.heightAnchor.constraint(equalTo: view.heightAnchor,
                                           constant: -view.frame.height*19/20),
            
            infoTable.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor,
                                           constant: view.frame.height/40),
            infoTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoTable.widthAnchor.constraint(equalTo: view.widthAnchor,
                                             constant: -view.frame.width/5),
            infoTable.heightAnchor.constraint(equalTo: view.heightAnchor,
                                              constant: -view.frame.height*3/4),
            
            
            wishlistButton.topAnchor.constraint(equalTo: infoTable.bottomAnchor,
                                                constant:view.frame.height/40),
            wishlistButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wishlistButton.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                  constant: -view.frame.width/5),
            wishlistButton.heightAnchor.constraint(equalTo: view.heightAnchor,
                                                   constant: -view.frame.height*19/20),
            
            updateButton.topAnchor.constraint(equalTo: wishlistButton.bottomAnchor,
                                              constant: view.frame.height/7),
            updateButton.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                constant: -view.frame.width/5),
            updateButton.heightAnchor.constraint(equalTo: view.heightAnchor,
                                                 constant: -view.frame.height*19/20),
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier, for: indexPath)
        let leftLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 200, height: 20))
        leftLabel.settingsUI(textAlignment: .left,
                            text: profileInfoTitle[indexPath.row],
                            backgroundColor: ColorSkin.default.strategy.invisibleBackground(),
                            tintColor: ColorSkin.default.strategy.fontColor(),
                            masksToBounds: false,
                            cornerRadius: 0)
        cell.backgroundColor = ColorSkin.default.strategy.invisibleBackground()
        
        cell.addSubview(leftLabel)
        cell.textLabel?.textAlignment = .right
        cell.textLabel?.textColor = ColorSkin.default.strategy.fontColor()
        cell.textLabel?.text = profileInfo[indexPath.row]
        
        return cell
    }
}

extension ProfileViewController: ProfileView{
    func showError(_ error: Error) {
    }
    
    func handleSuccess(profile: Employee) {
        myProfile = profile
        drawProfile(profile: profile)
    }
}

extension ProfileViewController{
    @objc func handleUpdateTouchUpInside() {
        let vc = ProfileUpdateViewController(profile: myProfile)
        vc.delegate = presenter
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    @objc func handleWishlistTouchUpInside() {
        let vc = assembly.createWishlistViewController(id: meId)
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    @objc func switchStateDidChange(_ sender:UISwitch!)
        {
            
                let delegateVC = self
                delegateVC.delegate = self
                ColorSkin.default.switchStrategy()
                delegateVC.changeColorView()
                delegateNotification?.changeColorView()
                delegateTabBar?.changeColorView()
        }
    
    func changeColorView(){
        wishlistButton.backgroundColor = ColorSkin.default.strategy.buttonBackgroundColor()
        wishlistButton.layer.borderColor = ColorSkin.default.strategy.buttonBorderColor()
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        updateButton.backgroundColor = ColorSkin.default.strategy.buttonBackgroundColor()
        fullNameLabel.backgroundColor = ColorSkin.default.strategy.invisibleBackground()
        background = ColorSkin.default.strategy.gradient()
        infoTable.reloadData()
        header.textColor = ColorSkin.default.strategy.fontColor()
        updateButton.setTitleColor(ColorSkin.default.strategy.fontColor(), for: .normal)
        wishlistButton.setTitleColor(ColorSkin.default.strategy.fontColor(), for: .normal) 
        view.layer.insertSublayer(background, at: 0)
    }
}
protocol ProfileUpdate{
    func showError(error: Error)
    func handleSuccess()
}
class ProfileUpdateViewController: UIViewController, ProfileUpdate{
    var updateNameTextField: UITextField!
    var updatePhoneTextField: UITextField!
    var updateCityTextField: UITextField!
    var updateBirthdayTextField: UITextField!
    var updateDateOfStartWork: UITextField!
    var commitChangesButton: UIButton!
    var backButton: UIButton!
    var header: UILabel!
    var myProfile: Employee!
    let presenter = ProfilePresenterImpl(service: EmployeeServiceImpl())
    weak var delegate: ProfilePresenterImpl?
    
    func showError(error: Error){
        print(error)
        print()
    }
    func handleSuccess(){
        delegate?.getProfile(myEmployee: meId)
        self.dismiss(animated: true, completion: nil)
    }
    init(profile: Employee){
        super.init(nibName:nil, bundle:nil)
        myProfile = profile
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.updateView = self
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        drawView()
        addSubviewsTurnOnConstraints(view: view, elements: [backButton,
                                                            header,
                                                            updateNameTextField,
                                                            updateCityTextField,
                                                            updatePhoneTextField,
                                                            updateBirthdayTextField,
                                                            updateDateOfStartWork,
                                                            commitChangesButton])
        doConstraintsMagic()
    }
    
    func drawView(){
        header = UILabel()
        header.text = "Редактировать профиль"
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
        
        updateNameTextField = UITextField(frame: .zero)
        updateNameTextField.settingUI(placeholder: "Имя")
        updateBirthdayTextField = UITextField(frame: .zero)
        updateBirthdayTextField.settingUI(placeholder: "День рождения")
        updateCityTextField = UITextField(frame: .zero)
        updateCityTextField.settingUI(placeholder: "Город")
        updatePhoneTextField = UITextField(frame: .zero)
        updatePhoneTextField.settingUI(placeholder: "Номер Телефона")
        updateDateOfStartWork = UITextField(frame: .zero)
        updateDateOfStartWork.settingUI(placeholder: "Начало работы")
        commitChangesButton = UIButton(type: .system)
        commitChangesButton.settingsUI(backgroundColor: ColorSkin.default.strategy.buttonBackgroundColor(),
                                       title: "Сохранить",
                                       titleColor: ColorSkin.default.strategy.fontColor(),
                                       cornerRadius: 10)
        commitChangesButton.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
    }
    
    func doConstraintsMagic(){
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
            
            updateNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateNameTextField.topAnchor.constraint(equalTo: view.topAnchor,
                                                     constant: 150),
            updateNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                       constant: -40),
            updatePhoneTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updatePhoneTextField.topAnchor.constraint(equalTo: updateNameTextField.bottomAnchor,
                                                     constant: 40),
            updatePhoneTextField.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                       constant: -40),
            
            updateCityTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateCityTextField.topAnchor.constraint(equalTo: updatePhoneTextField.bottomAnchor,
                                                     constant: 40),
            updateCityTextField.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                       constant: -40),
            
            updateBirthdayTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateBirthdayTextField.topAnchor.constraint(equalTo: updateCityTextField.bottomAnchor,
                                                     constant: 40),
            updateBirthdayTextField.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                       constant: -40),
            
            updateDateOfStartWork.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateDateOfStartWork.topAnchor.constraint(equalTo: updateBirthdayTextField.bottomAnchor,
                                                     constant: 40),
            updateDateOfStartWork.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                       constant: -40),
            
            commitChangesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            commitChangesButton.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                       constant: -100),
            commitChangesButton.topAnchor.constraint(equalTo: updateDateOfStartWork.bottomAnchor,
                                                     constant: 100)
        ])
    }
    
    @objc func saveButton(){
        
        if let name = updateNameTextField.text{
            if name != ""{
                myProfile.fullName = name
            }
        }
        if let bth = updateBirthdayTextField.text {
            if bth != ""{
                myProfile.birthday = bth
            }
        }
        if let city = updateCityTextField.text {
            if city != ""{
                myProfile.city = city
            }
        }
        if let phone = updatePhoneTextField.text {
            if phone != ""{
                myProfile.phone = phone
            }
        }
        if let date = updateDateOfStartWork.text{
            if date != ""{
                myProfile.startWork = date
            }
        }
        presenter.update(myEmployee: myProfile)
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
}

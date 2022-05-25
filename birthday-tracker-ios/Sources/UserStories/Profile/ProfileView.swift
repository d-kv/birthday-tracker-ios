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
    let header = UILabel()
    var picture = UIImageView(image: UIImage(named: "Trollface"))
    //let assembly = ProfileAssemblyImpl()
    let infoTable = UITableView()
    let presenter = ProfilePresenterImpl(service: EmployeeServiceImpl())
    var profileInfo = [String]()
    let wishlistButton = UIButton(type: .system)
    let simpleTableIdentifier = "SimpleTableIdentifier"
    var updateButton = UIButton(type: .system)
    var profileInfoTitle = [String]()
    let swithTheme = UISwitch()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        presenter.getProfile(myEmployee: meId)
    }
    
    
    func drawProfile(profile: Employee){
        navigationItem.title = "Профиль"
        profileInfo = [profile.phone, profile.city, profile.birthday, profile.startWork,   "\(profile.projects.count)"]
        profileInfoTitle = ["Связаться:", "Город:", "ДР:", "Начало работы:", "Кол-во проектов:"]
                            
        infoTable.backgroundColor = .white
        
        wishlistButton.settingsUI(backgroundColor: ColorSkin.default.strategy.buttonBackgroundColor(),
                                  title: "Список пожеланий",
                                  titleColor: ColorSkin.default.strategy.fontColor(),
                                  cornerRadius: 10,
                                  borderWidth: 2,
                                  borderColor: ColorSkin.default.strategy.buttonBorderColor())
        wishlistButton.addTarget(self, action: #selector(handleWishlistTouchUpInside), for: .touchUpInside)
        
        picture.backgroundColor = .white
        picture.layer.cornerRadius = 45
        picture.layer.borderWidth = 2
        picture.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        header.settingsUI(textAlignment: .center,
                          text: profile.fullName,
                          backgroundColor: ColorSkin.default.strategy.buttonBackgroundColor(),
                          tintColor: ColorSkin.default.strategy.fontColor(),
                          masksToBounds: true,
                          cornerRadius: 20,
                          borderWidth: 2,
                          borderColor: ColorSkin.default.strategy.buttonBorderColor())
        
        infoTable.register(UITableViewCell.self, forCellReuseIdentifier: "SimpleTableIdentifier")
        infoTable.dataSource = self
        infoTable.delegate = self
        
        
        updateButton.settingsUI(backgroundColor: ColorSkin.default.strategy.buttonBackgroundColor(),
                                title: "Редактировать",
                                titleColor: ColorSkin.default.strategy.fontColor(),
                                cornerRadius: 10,
                                borderWidth: 2,
                                borderColor: ColorSkin.default.strategy.buttonBorderColor())
        updateButton.addTarget(self, action: #selector(handleUpdateTouchUpInside), for: .touchUpInside)
        
        
        swithTheme.addTarget(self, action: #selector(self.switchStateDidChange(_:)), for: .valueChanged)
        swithTheme.setOn(true, animated: false)
        swithTheme.onTintColor = ColorSkin.default.strategy.buttonBackgroundColor()
        addSubviewsTurnOnConstraints(view: view,
                                     elements: [header, picture,
                                                infoTable, wishlistButton,
                                                updateButton, swithTheme])
        doConstraintsMagic()
    }
    
    
    func doConstraintsMagic(){
        NSLayoutConstraint.activate([
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
            
            header.topAnchor.constraint(equalTo: picture.bottomAnchor,
                                        constant: view.frame.height/40),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.widthAnchor.constraint(equalTo: view.widthAnchor,
                                          constant: -view.frame.width/5),
            header.heightAnchor.constraint(equalTo: view.heightAnchor,
                                           constant: -view.frame.height*19/20),
            
            infoTable.topAnchor.constraint(equalTo: header.bottomAnchor,
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
                                                  constant: -view.frame.width/2),
            updateButton.heightAnchor.constraint(equalTo: view.heightAnchor,
                                                   constant: -view.frame.height*97/100),
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
                             backgroundColor: .white,
                             tintColor: ColorSkin.default.strategy.fontColor(),
                             masksToBounds: false,
                             cornerRadius: 0,
                             borderWidth: 0,
                             borderColor: ColorSkin.default.strategy.buttonBorderColor())
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
        drawProfile(profile: profile)
    }
}

extension ProfileViewController{
    @objc func handleUpdateTouchUpInside() {
        let vc = ProfileUpdateViewController()
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
        header.backgroundColor = ColorSkin.default.strategy.buttonBackgroundColor()
        
        
    }
}

class ProfileUpdateViewController: UIViewController{
    var navBar: UINavigationBar!
    var navItem: UINavigationItem!
    var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        drawView()
        addSubviewsTurnOnConstraints(view: view, elements: [navBar])
        doConstraintsMagic()
    }
    
    func drawView(){
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: view.frame.size.width, height: 44))
        navItem = UINavigationItem(title: "Редактировать профиль")
        navItem.titleView?.tintColor = ColorSkin.default.strategy.fontColor()
        backButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                         target: self,
                                       action: #selector(back))
        navItem.leftBarButtonItem = backButton
        navBar.setItems([navItem], animated: false)
    }
    
    func doConstraintsMagic(){
        NSLayoutConstraint.activate([
            navBar.heightAnchor.constraint(equalToConstant: 44),
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            navBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
}

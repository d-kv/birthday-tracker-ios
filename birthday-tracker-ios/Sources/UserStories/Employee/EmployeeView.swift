//
//  EmployeeView.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import UIKit

class EmployeeViewController: UIViewController{
    
    let assembly = WishlistAssemblyImpl()
    let header = UILabel()
    var picture = UIImageView(image: UIImage(named: "Trollface"))
    //let assembly = ProfileAssemblyImpl()
    let infoTable = UITableView()
    let presenter = ProfilePresenterImpl(service: EmployeeServiceImpl())
    var profileInfo = [String]()
    let wishlistButton = UIButton(type: .system)
    let simpleTableIdentifier = "SimpleTableIdentifier"
    var profileInfoTitle = [String]()
    var profile: Employee!
    var navBar: UINavigationBar!
    var navItem: UINavigationItem!
    var backButton: UIBarButtonItem!
    
    init(employee: Employee) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overCurrentContext
        profile = employee
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        drawProfile()
    }
    
    
    func drawProfile(){
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: view.frame.size.width, height: 44))
        navItem = UINavigationItem(title: "Профиль именинника")
        navItem.titleView?.tintColor = ColorSkin.default.strategy.fontColor()
        backButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                         target: self,
                                       action: #selector(back))
        navItem.leftBarButtonItem = backButton
        navBar.setItems([navItem], animated: false)
        
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
        
        
        addSubviewsTurnOnConstraints(view: view,
                                     elements: [header, picture,
                                                infoTable, wishlistButton,
                                                navBar])
        doConstraintsMagic()
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func doConstraintsMagic(){
        NSLayoutConstraint.activate([
            navBar.heightAnchor.constraint(equalToConstant: 44),
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            navBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
                                                   constant: -view.frame.height*19/20)
        ])
    }
    
    @objc func handleWishlistTouchUpInside() {
        let vc = assembly.createWishlistViewController(id: profile.id)
        present(vc, animated: true)
    }
}

extension EmployeeViewController: UITableViewDelegate, UITableViewDataSource{
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


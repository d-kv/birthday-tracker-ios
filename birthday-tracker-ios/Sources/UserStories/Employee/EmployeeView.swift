//
//  EmployeeView.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import UIKit

class EmployeeViewController: UIViewController{
    
    let assembly = WishlistAssemblyImpl()
    let nameLabel = UILabel()
    var picture = UIImageView(image: UIImage(named: "Trollface"))
    //let assembly = ProfileAssemblyImpl()
    let infoTable = UITableView()
    let presenter = ProfilePresenterImpl(service: EmployeeServiceImpl())
    var profileInfo = [String]()
    let wishlistButton = UIButton(type: .system)
    let simpleTableIdentifier = "SimpleTableIdentifier"
    var profileInfoTitle = [String]()
    var profile: Employee!
    var backButton: UIButton!
    var header: UILabel!
    
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
        infoTable.backgroundColor = ColorSkin.default.strategy.invisibleBackground()
        header = UILabel()
        header.text = "Профиль именинника"
        header.textAlignment = .center
        header.textColor = ColorSkin.default.strategy.fontColor()
        backButton = UIButton()
        backButton.settingsUI(backgroundColor: ColorSkin.default.strategy.invisibleBackground(),
                              title: "Назад",
                              titleColor: ColorSkin.default.strategy.fontColor(),
                              cornerRadius: 0)
        backButton.addTarget(self,
                             action: #selector(back),
                             for: .touchUpInside)
        
        
        profileInfo = [profile.phone, profile.city, profile.birthday, profile.startWork,   "\(profile.projects.count)"]
        profileInfoTitle = ["Связаться:", "Город:", "ДР:", "Начало работы:", "Кол-во проектов:"]
        
        wishlistButton.settingsUI(backgroundColor: ColorSkin.default.strategy.buttonBackgroundColor(),
                                  title: "Список пожеланий",
                                  titleColor: ColorSkin.default.strategy.fontColor(),
                                  cornerRadius: 10)
        wishlistButton.addTarget(self, action: #selector(handleWishlistTouchUpInside), for: .touchUpInside)
        
        picture.backgroundColor = .white
        picture.layer.cornerRadius = 45
        picture.layer.borderWidth = 2
        picture.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        nameLabel.settingsUI(textAlignment: .center,
                          text: profile.fullName,
                          backgroundColor: ColorSkin.default.strategy.buttonBackgroundColor(),
                          tintColor: ColorSkin.default.strategy.fontColor(),
                          masksToBounds: true,
                          cornerRadius: 20)
        
        infoTable.register(UITableViewCell.self, forCellReuseIdentifier: "SimpleTableIdentifier")
        infoTable.dataSource = self
        infoTable.delegate = self
        
        
        addSubviewsTurnOnConstraints(view: view,
                                     elements: [header, picture,
                                                infoTable, wishlistButton,
                                                backButton, nameLabel])
        doConstraintsMagic()
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
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
            //trollface constraints
            picture.widthAnchor.constraint(equalTo: view.widthAnchor,
                                           constant: -view.frame.width*6/10),
            picture.heightAnchor.constraint(equalTo: view.widthAnchor,
                                            constant: -view.frame.width*6/10),
            picture.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                             constant: -view.frame.width*2/3),
            picture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: picture.bottomAnchor,
                                        constant: view.frame.height/40),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor,
                                          constant: -view.frame.width/5),
            nameLabel.heightAnchor.constraint(equalTo: view.heightAnchor,
                                           constant: -view.frame.height*19/20),
            
            infoTable.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
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


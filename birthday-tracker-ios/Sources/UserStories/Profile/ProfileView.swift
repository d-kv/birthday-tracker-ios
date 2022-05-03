//
//  ProfileView.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 28.03.2022.
//

import UIKit

protocol ProfileView {
    func showError(_ error: Error)
    func handleSuccess(profile: Employee)
}

class ProfileViewController: UIViewController, ProfileView {
    let assembly = ProfileAssemblyImpl()
    let infoTable = UITableView()
    let wishlistButton = UIButton(type: .system)
    let presenter = ProfilePresenterImpl(service: EmployeeServiceImpl())
    var picture = UIImageView(image: UIImage(named: "Trollface"))
    let header = UILabel()
    
    func showError(_ error: Error) {
        print("ViewProfileError")
    }
    
    func handleSuccess(profile: Employee) {
        print("successProfile")
        drawProfile(profile: profile)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        view.backgroundColor = .darkGray
        presenter.getProfile(myEmployee: 1)
    }
    
    func drawProfile(profile: Employee){
        infoTable.backgroundColor = .white
        wishlistButton.backgroundColor = .yellow
        wishlistButton.setTitle("Список пожеланий", for: .normal)
        wishlistButton.tintColor = .black
        wishlistButton.layer.cornerRadius = 10
        wishlistButton.layer.borderWidth = 2
        wishlistButton.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        picture.backgroundColor = .white
        picture.layer.cornerRadius = 45
        picture.layer.borderWidth = 2
        picture.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        header.textAlignment = .center
        header.text = profile.fullName
        header.backgroundColor = .yellow
        header.layer.masksToBounds = true
        header.layer.cornerRadius = 20
        header.layer.borderWidth = 2
        header.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        addSubviewsTurnOnConstraints(view: view, elements: [header, picture,
                                                           infoTable, wishlistButton])
        doConstraintsMagic()
    }
    
    func doConstraintsMagic(){
        NSLayoutConstraint.activate([
            //trollface constraints
            picture.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -view.frame.width*6/10),
            picture.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -view.frame.width*6/10),
            picture.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.width*2/3),
            picture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            header.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: view.frame.height/40),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -view.frame.width/5),
            header.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -view.frame.height*19/20),
            
            infoTable.topAnchor.constraint(equalTo: header.bottomAnchor, constant: view.frame.height/40),
            infoTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoTable.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -view.frame.width/5),
            infoTable.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -view.frame.height*2/3),
            
            
            wishlistButton.topAnchor.constraint(equalTo: infoTable.bottomAnchor,
                                                constant:view.frame.height/40),
            wishlistButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wishlistButton.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                  constant: -view.frame.width/5),
            wishlistButton.heightAnchor.constraint(equalTo: view.heightAnchor,
                                                   constant: -view.frame.height*19/20)
            
        ])
    }
    
}



//
//  WishlistView.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import UIKit

protocol WishlistView {
    func showError(_ error: Error)
    func handleSuccess(employee: Employee)
}

class WishlistViewController: UIViewController, WishlistView {
    let labelTitle = UILabel()
    let presenter = WishlistPresenterImpl(service: EmployeeServiceImpl())
    var wishlist = [Present(id: 0, name: "", link: "", presentDescription: "", employeeID: 0)]
    let simpleTableIdentifier = "SimpleTableIdentifier"
    let wishlistTable = UITableView()
    
    func showError(_ error: Error) {
        addSubviewsTurnOnConstraints(view: view, elements: [labelTitle])
        doConstraintMagicBad()
    }
    
    func handleSuccess(employee: Employee) {
        wishlistTable.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        wishlist = employee.wishlist
        addSubviewsTurnOnConstraints(view: view, elements: [labelTitle, wishlistTable])
        doConstraintMagicGood()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        
        labelTitle.settingsUI(textAlignment: .center,
                              text: "Список пожеланий",
                              backgroundColor: ColorSkin.default.strategy.buttonBackgroundColor(),
                              tintColor: ColorSkin.default.strategy.fontColor(),
                              masksToBounds: true,
                              cornerRadius: 10,
                              borderWidth: 2,
                              borderColor: CGColor(red: 0, green: 0, blue: 0, alpha: 1))
        
        
        wishlistTable.register(UITableViewCell.self, forCellReuseIdentifier: "SimpleTableIdentifier")
        wishlistTable.dataSource = self
        wishlistTable.delegate = self
        
        presenter.view = self
        presenter.getProfile(myEmployee: meId)
    }
    
    
    func doConstraintMagicGood(){
        NSLayoutConstraint.activate([
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTitle.topAnchor.constraint(equalTo: view.topAnchor),
            labelTitle.widthAnchor.constraint(equalTo: view.widthAnchor),
            labelTitle.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -view.frame.height*19/20),
            
        
            wishlistTable.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: view.frame.height/40),
            wishlistTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wishlistTable.widthAnchor.constraint(equalTo: view.widthAnchor),
            wishlistTable.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -view.frame.height*1/20),
        ])
    }
    
    func doConstraintMagicBad(){
        NSLayoutConstraint.activate([
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTitle.topAnchor.constraint(equalTo: view.topAnchor),
            labelTitle.widthAnchor.constraint(equalTo: view.widthAnchor),
            labelTitle.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -view.frame.height*19/20)
        ])

    }
    
}

extension WishlistViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishlist.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier, for: indexPath)
        cell.textLabel?.text = wishlist[indexPath.row].name
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = ColorSkin.default.strategy.buttonBorderColor()
        cell.layer.borderWidth = 2
        let button = UIButton(frame: .init(x: 0, y: 0, width: 400, height: 500))
        button.backgroundColor = .green.withAlphaComponent(0)
        button.tag = indexPath.row
        button.addTarget(self, action: #selector(touchCell), for: .touchUpInside)
        cell.addSubview(button)
        cell.backgroundColor = ColorSkin.default.strategy.whishlistCellBackroundColor()
        return cell
    }
    
    @objc func touchCell(sender:UIButton){
        var popUpWindow: PresentViewController!
        popUpWindow = PresentViewController(title: wishlist[sender.tag].name,
                                            text: wishlist[sender.tag].presentDescription,
                                            linkText: wishlist[sender.tag].link,
                                            buttontext: "Закрыть")
        self.present(popUpWindow, animated: true, completion: nil)
    }
}

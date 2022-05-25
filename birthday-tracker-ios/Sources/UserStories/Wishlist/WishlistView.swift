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
    let presenter = WishlistPresenterImpl(service: EmployeeServiceImpl())
    var wishlist = [Present(id: 0, name: "", link: "", presentDescription: "", employeeID: 0)]
    let simpleTableIdentifier = "SimpleTableIdentifier"
    let wishlistTable = UITableView()
    let addPresentButton = UIButton()
    var employeeID: Int!
    var navBar: UINavigationBar!
    var navItem: UINavigationItem!
    var backButton: UIBarButtonItem!
    
    init(employeeId: Int){
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        employeeID = employeeId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showError(_ error: Error) {
        addSubviewsTurnOnConstraints(view: view, elements: [])
        doConstraintMagicBad()
    }
    
    func handleSuccess(employee: Employee) {
        wishlistTable.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        wishlist = employee.wishlist
        addSubviewsTurnOnConstraints(view: view, elements: [wishlistTable, navBar])
        doConstraintMagicGood()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: view.frame.size.width, height: 44))
        navItem = UINavigationItem(title: "Список пожеланий")
        navItem.titleView?.tintColor = ColorSkin.default.strategy.fontColor()
        backButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                         target: self,
                                       action: #selector(back))
        navItem.leftBarButtonItem = backButton
        navBar.setItems([navItem], animated: false)
        
        presenter.view = self
        presenter.getProfile(myEmployee: employeeID)
        
        if employeeID == meId{
            addPresentButton.settingsUI(backgroundColor: ColorSkin.default.strategy.buttonBackgroundColor(),
                                        title: "Добавить подарок",
                                        titleColor: ColorSkin.default.strategy.fontColor(),
                                        cornerRadius: 10,
                                        borderWidth: 2,
                                        borderColor: ColorSkin.default.strategy.buttonBorderColor())
            addPresentButton.addTarget(self, action: #selector(touchAddButton(sender:)),
                                       for: .touchUpInside)
            addSubviewsTurnOnConstraints(view: view, elements: [addPresentButton])
            NSLayoutConstraint.activate([
                    addPresentButton.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                             constant: -view.frame.width/2),
                    addPresentButton.heightAnchor.constraint(equalToConstant: view.frame.height*1/20),
                    addPresentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    addPresentButton.topAnchor.constraint(equalTo: view.topAnchor,
                                                          constant: view.frame.width*5/3),
                ])
        }
        wishlistTable.register(UITableViewCell.self,
                               forCellReuseIdentifier: "SimpleTableIdentifier")
        wishlistTable.dataSource = self
        wishlistTable.delegate = self
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func touchAddButton(sender:UIButton){
        var popUpWindow: AddPresentViewController!
        popUpWindow = AddPresentViewController()
        popUpWindow.modalPresentationStyle = .overCurrentContext

        self.present(popUpWindow, animated: true, completion: nil)
    }
    
    func doConstraintMagicGood(){
        NSLayoutConstraint.activate([
            navBar.heightAnchor.constraint(equalToConstant: 44),
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            navBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            navBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            wishlistTable.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: view.frame.height/40),
            wishlistTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wishlistTable.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            wishlistTable.heightAnchor.constraint(equalTo: view.widthAnchor,
                                                  constant: view.frame.width/5)
        ])
    }
    
    func doConstraintMagicBad(){
        NSLayoutConstraint.activate([
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

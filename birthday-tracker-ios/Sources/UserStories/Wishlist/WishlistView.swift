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
    var header: UILabel!
    var backButton: UIButton!
    
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
        wishlist = employee.wishlist
        wishlistTable.reloadData()
        doConstraintMagicGood()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        
        draw()
    }
    
    func draw(){
        header = UILabel()
        header.text = "Список пожеланий"
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
        wishlistTable.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        wishlistTable.rowHeight = 60
        addSubviewsTurnOnConstraints(view: view, elements: [wishlistTable, backButton,
                                                           header])
        presenter.view = self
        presenter.getProfile(myEmployee: employeeID)
        
        if employeeID == meId{
            addPresentButton.settingsUI(backgroundColor: ColorSkin.default.strategy.buttonBackgroundColor(),
                                        title: "Добавить подарок",
                                        titleColor: ColorSkin.default.strategy.fontColor(),
                                        cornerRadius: 10)
            addPresentButton.addTarget(self, action: #selector(touchAddButton(sender:)),
                                       for: .touchUpInside)
            addSubviewsTurnOnConstraints(view: view, elements: [addPresentButton])
            NSLayoutConstraint.activate([
                    addPresentButton.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                             constant: -view.frame.width/2),
                    addPresentButton.heightAnchor.constraint(equalToConstant: view.frame.height*1/20),
                    addPresentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    addPresentButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                            constant: -50)
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
        popUpWindow.delegate = self
        self.present(popUpWindow, animated: true, completion: nil)
    }
    
    func doConstraintMagicGood(){
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
            
            wishlistTable.topAnchor.constraint(equalTo: view.topAnchor,
                                              constant: 100),
            wishlistTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            wishlistTable.rightAnchor.constraint(equalTo: view.rightAnchor),
            wishlistTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func doConstraintMagicBad(){
        NSLayoutConstraint.activate([
        ])

    }
    
}

extension WishlistViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        wishlist.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier, for: indexPath)
        cell.textLabel?.text = wishlist[indexPath.section].name
        cell.textLabel?.textColor = ColorSkin.default.strategy.fontColor()
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        let button = UIButton(frame: .init(x: 0, y: 0, width: 400, height: 500))
        button.backgroundColor = .green.withAlphaComponent(0)
        button.tag = indexPath.section
        button.addTarget(self, action: #selector(touchCell), for: .touchUpInside)
        cell.addSubview(button)
        cell.backgroundColor = ColorSkin.default.strategy.cellColor()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
        
        // Make the background color show through
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = ColorSkin.default.strategy.invisibleBackground()
        return headerView
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


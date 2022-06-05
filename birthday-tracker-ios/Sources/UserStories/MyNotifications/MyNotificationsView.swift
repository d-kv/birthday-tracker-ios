//
//  MyNotificationsView.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import UIKit

protocol MyNotificationsView {
    func showError(_ error: Error)
    func handleSuccess(notifications: [MyNotifications])
}

class MyNotificationsViewController: UIViewController{
    let presenter = MyNotificationPresenterImpl(service: MyNotificationServiceImpl())
    let notificationIdentifier = "notification"
    var notificationDataSource = [MyNotifications]()
    let notificationTable = UITableView()
    let label = UILabel()
    var header: UILabel!
    let background = ColorSkin.default.strategy.gradient()
                                                  
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.getNotifications(id: meId)
    }
}


//табличные делегаты шмалегаты
extension MyNotificationsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return notificationDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: notificationIdentifier, for: indexPath)
        cell.backgroundColor = ColorSkin.default.strategy.cellColor()
        cell.textLabel?.textAlignment = .right
        cell.textLabel?.textColor = ColorSkin.default.strategy.fontColor()
        cell.layer.cornerRadius = 10
        let button = UIButton(frame: .init(x: 0, y: 0, width: 400, height: 500))
        button.backgroundColor = .green.withAlphaComponent(0)
        button.tag = indexPath.section
        button.addTarget(self, action: #selector(touchCell), for: .touchUpInside)
        cell.addSubview(button)
        cell.textLabel?.text = notificationDataSource[indexPath.section].employee.fullName
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 0.6
        cell.layer.shadowOffset = CGSize.zero
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
        
        // Make the background color show through
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = ColorSkin.default.strategy.invisibleBackground()
        return headerView
    }
    
    
    @objc func touchCell(sender:UIButton){
        let vc = EmployeeViewController(employee: notificationDataSource[sender.tag].employee)
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
}


//протокол презентера
extension MyNotificationsViewController: MyNotificationsView{
    func showError(_ error: Error) {
        drawEmptyNotifications()
    }
    
    func handleSuccess(notifications: [MyNotifications]) {
        drawNotifications(notifications: notifications)
    }
}


//смена цветокора
extension MyNotificationsViewController: ColorShifter{
    func changeColorView() {
        label.backgroundColor = ColorSkin.default.strategy.messageBackgroundColor()
        notificationTable.backgroundColor = ColorSkin.default.strategy.invisibleBackground()
        notificationTable.reloadData()
        navigationItem.titleView?.tintColor = ColorSkin.default.strategy.fontColor()
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        presenter.getNotifications(id: meId)
    }
}


//Когда получили ответ
extension MyNotificationsViewController {
    func drawNotifications(notifications: [MyNotifications]){
        header = UILabel()
        header.text = "Ближайшие дни рождения"
        header.textAlignment = .center
        header.textColor = ColorSkin.default.strategy.fontColor()
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        background.frame = view.bounds
        view.layer.insertSublayer(background, at: 0)
        notificationDataSource = notifications
        notificationTable.register(UITableViewCell.self, forCellReuseIdentifier: "notification")
        notificationTable.dataSource = self
        notificationTable.delegate = self
        notificationTable.rowHeight = 80
        notificationTable.backgroundColor = ColorSkin.default.strategy.invisibleBackground()
        navigationItem.titleView?.tintColor = ColorSkin.default.strategy.fontColor()
        navigationController?.navigationBar.tintColor = .white
        addSubviewsTurnOnConstraints(view: view, elements: [notificationTable, header])
        doConstraintMagicGoodRequest()
    }
    
    func doConstraintMagicGoodRequest(){
        NSLayoutConstraint.activate([
            header.heightAnchor.constraint(equalToConstant: 44),
            header.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            header.widthAnchor.constraint(equalTo: view.widthAnchor),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            notificationTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notificationTable.topAnchor.constraint(equalTo: view.topAnchor,
                                                   constant: 100),
            notificationTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            notificationTable.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                     constant: -40)
        ])
    }
}


//когда не получили
extension MyNotificationsViewController {
    func drawEmptyNotifications(){
        header = UILabel()
        header.text = "Ближайшие дни рождения"
        header.textAlignment = .center
        header.textColor = ColorSkin.default.strategy.fontColor()
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        background.frame = view.bounds
        view.layer.insertSublayer(background, at: 0)
        navigationController?.navigationBar.tintColor = .white
        label.settingsUI(textAlignment: .center,
                         text: "Можешь никого не поздравлять)",
                         backgroundColor: ColorSkin.default.strategy.messageBackgroundColor(),
                         tintColor: ColorSkin.default.strategy.fontColor(),
                         masksToBounds: true,
                         cornerRadius: 10)
        addSubviewsTurnOnConstraints(view: view, elements: [label, header])
        doConstraintMagicBadRequest()
    }
    
    func doConstraintMagicBadRequest(){
        NSLayoutConstraint.activate([
            header.heightAnchor.constraint(equalToConstant: 44),
            header.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            header.widthAnchor.constraint(equalTo: view.widthAnchor),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            label.widthAnchor.constraint(equalTo: view.widthAnchor,
                                         constant: -view.frame.width/3),
            label.heightAnchor.constraint(equalTo: view.heightAnchor,
                                          constant: -view.frame.height*13/14),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                           constant: -view.frame.height*4/10)
            ])
    }
}

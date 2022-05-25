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
                                                  
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.getNotifications(id: meId)
    }
}


//табличные делегаты шмалегаты
extension MyNotificationsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationDataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: notificationIdentifier, for: indexPath)
        cell.imageView!.image = UIImage(named: "Trollface")
        cell.imageView!.backgroundColor = .white
        cell.imageView!.layer.masksToBounds = true
        cell.imageView!.layer.borderColor = ColorSkin.default.strategy.buttonBorderColor()
        cell.imageView!.layer.cornerRadius = 10
        cell.imageView!.layer.borderWidth = 2
        cell.backgroundColor = ColorSkin.default.strategy.buttonBackgroundColor()
        cell.textLabel?.textAlignment = .right
        cell.textLabel?.textColor = ColorSkin.default.strategy.fontColor()
        cell.layer.cornerRadius = 10
        let button = UIButton(frame: .init(x: 0, y: 0, width: 400, height: 500))
        button.backgroundColor = .green.withAlphaComponent(0)
        button.tag = indexPath.row
        button.addTarget(self, action: #selector(touchCell), for: .touchUpInside)
        cell.addSubview(button)
        cell.textLabel?.text = notificationDataSource[indexPath.row].employee.fullName
        return cell
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
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        label.backgroundColor = ColorSkin.default.strategy.messageBackgroundColor()
        notificationTable.backgroundColor = ColorSkin.default.strategy.backgroundColor()
    }
}


//Когда получили ответ
extension MyNotificationsViewController {
    func drawNotifications(notifications: [MyNotifications]){
        notificationDataSource = notifications
        notificationTable.register(UITableViewCell.self, forCellReuseIdentifier: "notification")
        notificationTable.dataSource = self
        notificationTable.delegate = self
        notificationTable.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        navigationItem.title = "Ближайшие дни рождения"
        navigationController?.navigationBar.tintColor = .white
        addSubviewsTurnOnConstraints(view: view, elements: [notificationTable])
        doConstraintMagicGoodRequest()
    }
    
    func doConstraintMagicGoodRequest(){
        NSLayoutConstraint.activate([
            notificationTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notificationTable.topAnchor.constraint(equalTo: view.topAnchor,
                                                   constant: 40),
            notificationTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            notificationTable.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                     constant: -40)
        ])
    }
}


//когда не получили
extension MyNotificationsViewController {
    func drawEmptyNotifications(){
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        navigationController?.navigationBar.tintColor = .white
        label.settingsUI(textAlignment: .center,
                         text: "Можешь никого не поздравлять)",
                         backgroundColor: ColorSkin.default.strategy.messageBackgroundColor(),
                         tintColor: ColorSkin.default.strategy.fontColor(),
                         masksToBounds: true,
                         cornerRadius: 10,
                         borderWidth: 2,
                         borderColor: ColorSkin.default.strategy.buttonBorderColor())
        addSubviewsTurnOnConstraints(view: view, elements: [label])
        doConstraintMagicBadRequest()
    }
    
    func doConstraintMagicBadRequest(){
        NSLayoutConstraint.activate([
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

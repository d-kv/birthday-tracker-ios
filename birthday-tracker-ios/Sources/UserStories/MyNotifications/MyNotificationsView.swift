//
//  MyNotificationsView.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import UIKit

protocol MyNotificationsView {
    func showError(_ error: Error)
    func handleSuccess(notifications: MyNotifications)
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
    
    func drawNotifications(notifications: MyNotifications){
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        navigationItem.title = "Ближайшие дни рождения"
        navigationController?.navigationBar.tintColor = .white
        addSubviewsTurnOnConstraints(view: view, elements: [])
    }
    
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

extension MyNotificationsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationDataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: notificationIdentifier, for: indexPath)
            cell.textLabel?.text = "notificationDataSource[indexPath.row]"
            return cell
    }
}

extension MyNotificationsViewController: MyNotificationsView{
    func showError(_ error: Error) {
        drawEmptyNotifications()
    }
    
    func handleSuccess(notifications: MyNotifications) {
        drawNotifications(notifications: notifications)
    }
}

extension MyNotificationsViewController: ColorShifter{
    func changeColorView() {
        view.backgroundColor = ColorSkin.default.strategy.backgroundColor()
        label.backgroundColor = ColorSkin.default.strategy.messageBackgroundColor()
    }
}

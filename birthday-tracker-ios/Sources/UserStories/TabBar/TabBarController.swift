//
//  TabBarController.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 27.04.2022.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController, ColorShifter{
    private enum TabBarItem: Int {
        case myNotifications
        case profile

        var title: String {
            switch self {
            case .myNotifications:
                return "Ближайшие ДР"

            case .profile:
                return "Профиль"
            }
        }

        var iconName: String {
            switch self {
            case .myNotifications:
                return "gift"

            case .profile:
                return "person.crop.circle"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }

    private func setupTabBar() {
        let dataSource: [TabBarItem] = [.myNotifications, .profile]
        tabBar.backgroundColor = ColorSkin.default.strategy.tapBarBackgroundColor()
        tabBar.tintColor = ColorSkin.default.strategy.fontColor()
        tabBar.barTintColor = ColorSkin.default.strategy.fontColor()
        viewControllers = dataSource.map {
            switch $0 {
            case .myNotifications:
                let feedViewController = MyNotificationsViewController()
                return self.wrappedInNavigationController(with: feedViewController, title: $0.title)
            case .profile:
                let profile = ProfileAssemblyImpl()
                return self.wrappedInNavigationController(with: profile.createProfileViewController(), title: $0.title)
            }
        }

        viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
            $1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: .zero, bottom: -5, right: .zero)
        }
        
    }
    
    private func wrappedInNavigationController(with: UIViewController, title: Any?) -> UINavigationController {return UINavigationController(rootViewController: with)}
    
    func changeColorView() {
        tabBar.backgroundColor = ColorSkin.default.strategy.tapBarBackgroundColor()
        tabBar.tintColor = ColorSkin.default.strategy.fontColor()
        tabBar.barTintColor = ColorSkin.default.strategy.fontColor()
    }
}

//
//  ProfileAssembly.swift
//  birthday-tracker-ios
//
//  Created by Alex on 01.05.2022.
//

import Foundation
import UIKit

protocol ProfileAssembly {
    func createProfileViewController() -> UIViewController
}

final class ProfileAssemblyImpl {
    init() {}

    func createProfileViewController() -> UIViewController {
        let vc = ProfileViewController()
        return vc
    }
}

//
//  ProfileAssembly.swift
//  birthday-tracker-ios
//
//  Created by Alex on 01.05.2022.
//

import Foundation
import UIKit

protocol ProfileAssembly {
    func createProfileViewController() -> ProfileViewController
}

final class ProfileAssemblyImpl:  ProfileAssembly{
    init() {}

    func createProfileViewController() -> ProfileViewController {
        let vc = ProfileViewController()
        return vc
    }
}

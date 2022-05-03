//
//  MainAssembly.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 27.04.2022.
//

import Foundation
import UIKit

protocol MainAssembly {
    func createMainViewController() -> UIViewController
}

final class MainAssemblyImpl {
    init() {}

    func createMainViewController() -> UIViewController {
        let vc = TabBarController()
        return vc
    }
}

//
//  MainAssembly.swift
//  birthday-tracker-ios
//
//  Created by d.kuznetsov12 on 15.04.2022.
//

import Foundation
import UIKit

protocol MainAssembly {
    func createMainViewController() -> UIViewController
}

final class MainAssemblyImpl {
    
    init(){}
    
    func createMainViewController() -> UIViewController {
        // TODO: вернуть здесь главный экран приложения
        UIViewController()
    }
}

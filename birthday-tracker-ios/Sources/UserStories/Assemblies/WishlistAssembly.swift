//
//  WishlistAssembly.swift
//  birthday-tracker-ios
//
//  Created by Alex on 18.05.2022.
//

import Foundation
import UIKit

protocol WishlistAssembly {
    func createWishlistViewController(id: Int) -> UIViewController
}

final class WishlistAssemblyImpl: WishlistAssembly {
    init() {}

    func createWishlistViewController(id: Int) -> UIViewController {
        let vc = WishlistViewController(employeeId: id)
        return vc
    }
}

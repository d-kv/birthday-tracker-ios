//
//  WishlistAssembly.swift
//  birthday-tracker-ios
//
//  Created by Alex on 18.05.2022.
//

import Foundation
import UIKit

protocol WishlistAssembly {
    func createWishlistViewController() -> UIViewController
}

final class WishlistAssemblyImpl: WishlistAssembly {
    init() {}

    func createWishlistViewController() -> UIViewController {
        let vc = WishlistViewController()
        return vc
    }
}

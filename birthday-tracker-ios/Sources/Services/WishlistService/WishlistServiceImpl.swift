//
//  WishlistServiceImpl.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation
/* Wishlist не существует в Api, он передается внутри эмплоя - как тогда его load'ать?*/
class WishlistServiceImpl: WishlistService {
    func edit(employee _: Employee, completion _: () -> Void) {}

    func load(id _: Int, completion _: @escaping (Result<Wishlist, Error>) -> Void) {}
}

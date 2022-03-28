//
//  Profile.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 28.03.2022.
//

import Foundation

struct Profile: Codable{
    let id, project: Int
    let phone, name, city: String
    let birthday, startwork: Date
    let wishlist: Wishlist

    init(id: Int, project: Int, phone: String, name: String, city: String, birthday: Date, startwork: Date, wishlist: Wishlist) {
        self.id = id
        self.project = project
        self.phone = phone
        self.name = name
        self.city = city
        self.birthday = birthday
        self.startwork = startwork
        self.wishlist = wishlist
    }

    func getWishlist(id _: Int) {}
}

import Foundation

struct Employee: Codable{
    let id, project: Int?
    let phone, name, city: String?
    let birthday, startwork: String?
    let wishlist: Wishlist?

    init(id: Int, project: Int, phone: String, name: String, city: String, birthday: String, startwork: String, wishlist: Wishlist) {
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

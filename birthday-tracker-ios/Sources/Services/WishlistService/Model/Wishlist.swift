import Foundation

struct Wishlist: Codable {
    let id: Int
    let name, link, wishlistDescription: String
    let employeeID: Int

    enum CodingKeys: String, CodingKey {
        case id, name, link
        case wishlistDescription = "description"
        case employeeID = "employee_id"
    }
}

import Foundation

struct Employee: Codable {
    let id: Int
    let fullName, phone: String
    let projects: [Project]
    let birthday, startWork: String
    let wishlist: [Wishlist]
    let city, username: String

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case phone, projects, birthday
        case startWork = "start_work"
        case wishlist, city, username
    }
}

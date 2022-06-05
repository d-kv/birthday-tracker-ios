import Foundation

struct Employee: Codable {
    let id: Int
    var fullName, phone: String
    let projects: [Project]
    var birthday, startWork: String
    let wishlist: [Present]
    var city, username: String

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case phone, projects, birthday
        case startWork = "start_work"
        case wishlist, city, username
    }
}

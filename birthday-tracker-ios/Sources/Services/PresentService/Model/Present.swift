import Foundation

// MARK: - Present

struct Present: Codable {
    let id: Int
    let name: String
    let link: String
    let presentDescription: String
    let employeeID: Int

    enum CodingKeys: String, CodingKey {
        case id, name, link
        case presentDescription = "description"
        case employeeID = "employee_id"
    }
}

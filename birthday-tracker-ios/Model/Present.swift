import Foundation

class Present {
    let id: Int
    let name: String
    let link: String
    let description: String
    let employeeId: Int


    init(id: Int, name: String, link: String, description: String, employeeId: Int) {
        self.id = id
        self.name = name
        self.link = link
        self.description = description
        self.employeeId = employeeId
    }
}

import Foundation

struct MyNotifications: Codable {
    let projectId: Int
    let employees: [Employee]

    init(projectId: Int, employees: [Employee]) {
        self.projectId = projectId
        self.employees = employees
    }

    func getMyNotifications(userId _: Int) {}
}

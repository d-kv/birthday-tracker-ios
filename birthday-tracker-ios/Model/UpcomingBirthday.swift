import Foundation

struct UpcomingBirthdays {
    let projectId: Int
    let employees: [Employee]

    init(projectId: Int, employees: [Employee]) {
        self.projectId = projectId
        self.employees = employees
    }

    func getMyNotifications(userId _: Int) {}
}

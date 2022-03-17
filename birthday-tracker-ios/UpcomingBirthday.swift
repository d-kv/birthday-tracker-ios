import Foundation

class UpcomingBirthdays {
    let projectId: Int
    let employees: Array<Employee>
    
    init(_projectId: Int, _employees: Array<Employee>) {
        projectId = _projectId
        employees = _employees
    }
    
    func getMyNotifications(userId: Int) -> Array<Employee> {
        
    }
}

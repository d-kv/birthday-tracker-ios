import Foundation

struct UpcomingBirthdays {
    let projectId: Int
    let employees: Array<Employee>
    
    init(projectId: Int, employees: Array<Employee>) {
        self.projectId = projectId
        self.employees = employees
    }
    
    func getMyNotifications(userId: Int){
        
    }
}

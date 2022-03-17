import Foundation

class Wishlist {
    let employeeId: Int
    var presents: Array<Present>

    init(employeeId: Int, presents: Array<Present>){
        self.employeeId = employeeId
        self.presents = presents
    }

    func addPresent(present: Present) {
        self.presents.append(present)
    }
}

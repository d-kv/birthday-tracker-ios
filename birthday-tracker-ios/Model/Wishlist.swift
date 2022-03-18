import Foundation

struct Wishlist {
    let employeeId: Int
    var presents: Array<Present>

    init(employeeId: Int, presents: Array<Present>){
        self.employeeId = employeeId
        self.presents = presents
    }

    mutating func addPresent(present: Present) {
        self.presents.append(present)
    }
}

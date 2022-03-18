import Foundation

struct Wishlist {
    let employeeId: Int
    var presents: [Present]

    init(employeeId: Int, presents: [Present]) {
        self.employeeId = employeeId
        self.presents = presents
    }

    mutating func addPresent(present: Present) {
        presents.append(present)
    }
}

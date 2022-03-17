import Foundation

class Employee {
    let id, project: Int
    let phone, name, city: String
    let birthday, startwork: Date
    let wishlist: Wishlist
    
    init(_id: Int, _project: Int, _phone: String, _name: String, _city: String, _birthday: Date, _startwork: Date, _wishlist: Wishlist){
        id = _id
        project = _project
        phone = _phone
        name = _name
        city = _city
        birthday = _birthday
        startwork = _startwork
        wishlist = _wishlist
    }
    
    func getWishlist(id: Int) -> Array<Present> {
        
        
    }
    
}


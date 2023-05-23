
import Foundation
import FirebaseFirestoreSwift


struct User: Identifiable, Codable {
    
    @DocumentID var id: String?
    var name: String
    var lastName: String
    var age: Int
    var gender: String
    var email: String
    var role: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case lastName
        case age
        case gender
        case email
        case role
        case password
    }
}


import Foundation
import FirebaseFirestoreSwift


struct Product: Identifiable, Codable {
    
    @DocumentID var id: String?
    var name: String
    var description: String
    var units: Int
    var cost: Double
    var price: Double
    var utility: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case units
        case cost
        case price
        case utility
    }

}



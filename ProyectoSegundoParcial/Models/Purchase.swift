
import Foundation
import FirebaseFirestoreSwift


struct Purchase: Identifiable, Codable {
    
    @DocumentID var id: String?
    var productName: String
    var productId: String
    var pieces: Int
    var idA: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case productName
        case productId
        case pieces
        case idA
    }
}


import Foundation
import FirebaseFirestoreSwift


struct Sale: Identifiable, Codable {
    
    @DocumentID var id: String?
    var productName: String
    var productId: String
    var customerId: String
    var vendorId: String
    var amount: Double
    var pieces: Int
    var subtotal: Double
    var total: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case productName
        case productId
        case customerId
        case vendorId
        case amount
        case pieces
        case subtotal
        case total
    }
}


import Foundation
struct CH : Codable {
    let passengerCount : Int?
    let tax : String?
    let totalPrice : String?
    let baseFare : Double?

    enum CodingKeys: String, CodingKey {

        case passengerCount = "PassengerCount"
        case tax = "Tax"
        case totalPrice = "TotalPrice"
        case baseFare = "BaseFare"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        passengerCount = try values.decodeIfPresent(Int.self, forKey: .passengerCount)
        tax = try values.decodeIfPresent(String.self, forKey: .tax)
        totalPrice = try values.decodeIfPresent(String.self, forKey: .totalPrice)
        baseFare = try values.decodeIfPresent(Double.self, forKey: .baseFare)
    }

}

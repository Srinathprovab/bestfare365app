

import Foundation
struct FDFare_details : Codable {
	let baseFare : Int?
	let total_Tax : Int?
	let total_Fare : Int?

	enum CodingKeys: String, CodingKey {

		case baseFare = "BaseFare"
		case total_Tax = "Total_Tax"
		case total_Fare = "Total_Fare"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		baseFare = try values.decodeIfPresent(Int.self, forKey: .baseFare)
		total_Tax = try values.decodeIfPresent(Int.self, forKey: .total_Tax)
		total_Fare = try values.decodeIfPresent(Int.self, forKey: .total_Fare)
	}

}

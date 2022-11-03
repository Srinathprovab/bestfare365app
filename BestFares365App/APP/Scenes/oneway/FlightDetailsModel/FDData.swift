

import Foundation
struct FDData : Codable {
	let flight_details : [[FDFlight_details]]?
	let fare_rules : String?
	let fare_details : FDFare_details?

	enum CodingKeys: String, CodingKey {

		case flight_details = "flight_details"
		case fare_rules = "fare_rules"
		case fare_details = "fare_details"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		flight_details = try values.decodeIfPresent([[FDFlight_details]].self, forKey: .flight_details)
		fare_rules = try values.decodeIfPresent(String.self, forKey: .fare_rules)
		fare_details = try values.decodeIfPresent(FDFare_details.self, forKey: .fare_details)
	}

}

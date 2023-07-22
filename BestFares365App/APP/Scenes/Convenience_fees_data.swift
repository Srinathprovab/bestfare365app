

import Foundation
struct Convenience_fees_data : Codable {
	let origin : String?
	let module : String?
	let api : String?
	let value : String?
	let value_type : String?
	let per_pax : String?
	let convenience_fee_currency : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case module = "module"
		case api = "api"
		case value = "value"
		case value_type = "value_type"
		case per_pax = "per_pax"
		case convenience_fee_currency = "convenience_fee_currency"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		module = try values.decodeIfPresent(String.self, forKey: .module)
		api = try values.decodeIfPresent(String.self, forKey: .api)
		value = try values.decodeIfPresent(String.self, forKey: .value)
		value_type = try values.decodeIfPresent(String.self, forKey: .value_type)
		per_pax = try values.decodeIfPresent(String.self, forKey: .per_pax)
		convenience_fee_currency = try values.decodeIfPresent(String.self, forKey: .convenience_fee_currency)
	}

}

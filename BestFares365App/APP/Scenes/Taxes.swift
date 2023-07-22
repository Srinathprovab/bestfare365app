
import Foundation
struct Taxes : Codable {
	let taxes : [Taxes]?
	let allIncluded : Bool?

	enum CodingKeys: String, CodingKey {

		case taxes = "taxes"
		case allIncluded = "allIncluded"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		taxes = try values.decodeIfPresent([Taxes].self, forKey: .taxes)
		allIncluded = try values.decodeIfPresent(Bool.self, forKey: .allIncluded)
	}

}

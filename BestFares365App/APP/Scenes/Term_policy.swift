

import Foundation
struct Term_policy : Codable {
	let id : String?
	let terms_n_conditions : String?
	let cancellation_policy : String?
	let module_name : String?
	let status : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case terms_n_conditions = "terms_n_conditions"
		case cancellation_policy = "cancellation_policy"
		case module_name = "module_name"
		case status = "status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		terms_n_conditions = try values.decodeIfPresent(String.self, forKey: .terms_n_conditions)
		cancellation_policy = try values.decodeIfPresent(String.self, forKey: .cancellation_policy)
		module_name = try values.decodeIfPresent(String.self, forKey: .module_name)
		status = try values.decodeIfPresent(String.self, forKey: .status)
	}

}

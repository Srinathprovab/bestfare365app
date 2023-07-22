

import Foundation
struct Hotel_static_contact_num : Codable {
	let pType : String?
	let contactN : String?

	enum CodingKeys: String, CodingKey {

		case pType = "pType"
		case contactN = "contactN"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		pType = try values.decodeIfPresent(String.self, forKey: .pType)
		contactN = try values.decodeIfPresent(String.self, forKey: .contactN)
	}

}

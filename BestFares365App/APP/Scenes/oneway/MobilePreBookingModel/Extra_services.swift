
import Foundation
struct Extra_services : Codable {
	let status : Int?
	let data : [String]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		data = try values.decodeIfPresent([String].self, forKey: .data)
	}

}

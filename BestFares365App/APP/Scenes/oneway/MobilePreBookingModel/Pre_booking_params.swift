

import Foundation
struct Pre_booking_params : Codable {
	let search_id : String?
	let booking_source : String?
	let session_id : String?
	let search_url : String?
	let token : [Token]?
	let token_key : [String]?
	let extra_services : Extra_services?

	enum CodingKeys: String, CodingKey {

		case search_id = "search_id"
		case booking_source = "booking_source"
		case session_id = "session_id"
		case search_url = "search_url"
		case token = "token"
		case token_key = "token_key"
		case extra_services = "extra_services"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
		booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
		session_id = try values.decodeIfPresent(String.self, forKey: .session_id)
		search_url = try values.decodeIfPresent(String.self, forKey: .search_url)
		token = try values.decodeIfPresent([Token].self, forKey: .token)
		token_key = try values.decodeIfPresent([String].self, forKey: .token_key)
		extra_services = try values.decodeIfPresent(Extra_services.self, forKey: .extra_services)
	}

}

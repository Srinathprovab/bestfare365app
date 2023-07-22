

import Foundation
struct Active_data : Codable {
	let origin : String?
	let balance : String?
	let currency_converter_fk : String?
	let domain_name : String?
	let domain_ip : String?
	let domain_key : String?
	let theme_id : String?
	let b2b_theme_id : String?
	let status : String?
	let comment : String?
	let domain_logo : String?
	let created_by_id : String?
	let created_datetime : String?
	let test_username : String?
	let test_password : String?
	let live_username : String?
	let live_password : String?
	let phone : String?
	let email : String?
	let address : String?
	let api_country_list_fk : String?
	let api_city_list_fk : String?
	let admin_noti_mail : String?
	let seat_markup : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case balance = "balance"
		case currency_converter_fk = "currency_converter_fk"
		case domain_name = "domain_name"
		case domain_ip = "domain_ip"
		case domain_key = "domain_key"
		case theme_id = "theme_id"
		case b2b_theme_id = "b2b_theme_id"
		case status = "status"
		case comment = "comment"
		case domain_logo = "domain_logo"
		case created_by_id = "created_by_id"
		case created_datetime = "created_datetime"
		case test_username = "test_username"
		case test_password = "test_password"
		case live_username = "live_username"
		case live_password = "live_password"
		case phone = "phone"
		case email = "email"
		case address = "address"
		case api_country_list_fk = "api_country_list_fk"
		case api_city_list_fk = "api_city_list_fk"
		case admin_noti_mail = "admin_noti_mail"
		case seat_markup = "seat_markup"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		balance = try values.decodeIfPresent(String.self, forKey: .balance)
		currency_converter_fk = try values.decodeIfPresent(String.self, forKey: .currency_converter_fk)
		domain_name = try values.decodeIfPresent(String.self, forKey: .domain_name)
		domain_ip = try values.decodeIfPresent(String.self, forKey: .domain_ip)
		domain_key = try values.decodeIfPresent(String.self, forKey: .domain_key)
		theme_id = try values.decodeIfPresent(String.self, forKey: .theme_id)
		b2b_theme_id = try values.decodeIfPresent(String.self, forKey: .b2b_theme_id)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		comment = try values.decodeIfPresent(String.self, forKey: .comment)
		domain_logo = try values.decodeIfPresent(String.self, forKey: .domain_logo)
		created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
		created_datetime = try values.decodeIfPresent(String.self, forKey: .created_datetime)
		test_username = try values.decodeIfPresent(String.self, forKey: .test_username)
		test_password = try values.decodeIfPresent(String.self, forKey: .test_password)
		live_username = try values.decodeIfPresent(String.self, forKey: .live_username)
		live_password = try values.decodeIfPresent(String.self, forKey: .live_password)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		api_country_list_fk = try values.decodeIfPresent(String.self, forKey: .api_country_list_fk)
		api_city_list_fk = try values.decodeIfPresent(String.self, forKey: .api_city_list_fk)
		admin_noti_mail = try values.decodeIfPresent(String.self, forKey: .admin_noti_mail)
		seat_markup = try values.decodeIfPresent(String.self, forKey: .seat_markup)
	}

}

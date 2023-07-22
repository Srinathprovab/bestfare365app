

import Foundation
struct Traveller_details : Codable {
	let origin : String?
	let user_id : String?
	let first_name : String?
	let last_name : String?
	let date_of_birth : String?
	let email : String?
	let passport_user_name : String?
	let passport_nationality : String?
	let passport_expiry_day : String?
	let passport_expiry_month : String?
	let passport_expiry_year : String?
	let passport_number : String?
	let passport_issuing_country : String?
	let created_by_id : String?
	let created_datetime : String?
	let updated_by_id : String?
	let updated_datetime : String?
	let user_type : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case user_id = "user_id"
		case first_name = "first_name"
		case last_name = "last_name"
		case date_of_birth = "date_of_birth"
		case email = "email"
		case passport_user_name = "passport_user_name"
		case passport_nationality = "passport_nationality"
		case passport_expiry_day = "passport_expiry_day"
		case passport_expiry_month = "passport_expiry_month"
		case passport_expiry_year = "passport_expiry_year"
		case passport_number = "passport_number"
		case passport_issuing_country = "passport_issuing_country"
		case created_by_id = "created_by_id"
		case created_datetime = "created_datetime"
		case updated_by_id = "updated_by_id"
		case updated_datetime = "updated_datetime"
		case user_type = "user_type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
		first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
		last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
		date_of_birth = try values.decodeIfPresent(String.self, forKey: .date_of_birth)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		passport_user_name = try values.decodeIfPresent(String.self, forKey: .passport_user_name)
		passport_nationality = try values.decodeIfPresent(String.self, forKey: .passport_nationality)
		passport_expiry_day = try values.decodeIfPresent(String.self, forKey: .passport_expiry_day)
		passport_expiry_month = try values.decodeIfPresent(String.self, forKey: .passport_expiry_month)
		passport_expiry_year = try values.decodeIfPresent(String.self, forKey: .passport_expiry_year)
		passport_number = try values.decodeIfPresent(String.self, forKey: .passport_number)
		passport_issuing_country = try values.decodeIfPresent(String.self, forKey: .passport_issuing_country)
		created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
		created_datetime = try values.decodeIfPresent(String.self, forKey: .created_datetime)
		updated_by_id = try values.decodeIfPresent(String.self, forKey: .updated_by_id)
		updated_datetime = try values.decodeIfPresent(String.self, forKey: .updated_datetime)
		user_type = try values.decodeIfPresent(String.self, forKey: .user_type)
	}

}

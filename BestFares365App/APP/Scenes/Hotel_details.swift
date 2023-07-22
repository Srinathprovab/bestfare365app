
import Foundation
struct Hotel_details : Codable {
    
    
	let hotel_code : Int?
	let hotel_name : String?
	let categoryName : String?
	let destination : String?
	let destination_code : String?
	let zone_code : Int?
	let zone : String?
	let latitude : String?
	let longitude : String?
	let minRate : Double?
	let maxRate : String?
	let currency : String?
	let checkIn : String?
	let checkOut : String?
	let rooms : [[Rooms]]?
	let chain : String?
	let accomodation_type_code : String?
	let category_code : String?
	let address : String?
	let postal : String?
	let email : String?
	let website : String?
	let description : String?
	let image_arr : [Image_arr]?
	let medium_image_baseUrl : String?
	let small_image_baseUrl : String?
	let hotel_static_facilities_arr : [Hotel_static_facilities_arr]?
	let hotel_static_contact_num : [Hotel_static_contact_num]?
	let token : String?
	let tokenKey : String?
	let min_price : Double?

	enum CodingKeys: String, CodingKey {

		case hotel_code = "hotel_code"
		case hotel_name = "hotel_name"
		case categoryName = "categoryName"
		case destination = "destination"
		case destination_code = "destination_code"
		case zone_code = "zone_code"
		case zone = "zone"
		case latitude = "latitude"
		case longitude = "longitude"
		case minRate = "minRate"
		case maxRate = "maxRate"
		case currency = "currency"
		case checkIn = "checkIn"
		case checkOut = "checkOut"
		case rooms = "rooms"
		case chain = "chain"
		case accomodation_type_code = "accomodation_type_code"
		case category_code = "category_code"
		case address = "address"
		case postal = "postal"
		case email = "email"
		case website = "website"
		case description = "description"
		case image_arr = "image_arr"
		case medium_image_baseUrl = "medium_image_baseUrl"
		case small_image_baseUrl = "small_image_baseUrl"
		case hotel_static_facilities_arr = "hotel_static_facilities_arr"
		case hotel_static_contact_num = "hotel_static_contact_num"
		case token = "Token"
		case tokenKey = "TokenKey"
		case min_price = "min_price"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		hotel_code = try values.decodeIfPresent(Int.self, forKey: .hotel_code)
		hotel_name = try values.decodeIfPresent(String.self, forKey: .hotel_name)
		categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
		destination = try values.decodeIfPresent(String.self, forKey: .destination)
		destination_code = try values.decodeIfPresent(String.self, forKey: .destination_code)
		zone_code = try values.decodeIfPresent(Int.self, forKey: .zone_code)
		zone = try values.decodeIfPresent(String.self, forKey: .zone)
		latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
		minRate = try values.decodeIfPresent(Double.self, forKey: .minRate)
		maxRate = try values.decodeIfPresent(String.self, forKey: .maxRate)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		checkIn = try values.decodeIfPresent(String.self, forKey: .checkIn)
		checkOut = try values.decodeIfPresent(String.self, forKey: .checkOut)
		rooms = try values.decodeIfPresent([[Rooms]].self, forKey: .rooms)
		chain = try values.decodeIfPresent(String.self, forKey: .chain)
		accomodation_type_code = try values.decodeIfPresent(String.self, forKey: .accomodation_type_code)
		category_code = try values.decodeIfPresent(String.self, forKey: .category_code)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		postal = try values.decodeIfPresent(String.self, forKey: .postal)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		website = try values.decodeIfPresent(String.self, forKey: .website)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		image_arr = try values.decodeIfPresent([Image_arr].self, forKey: .image_arr)
		medium_image_baseUrl = try values.decodeIfPresent(String.self, forKey: .medium_image_baseUrl)
		small_image_baseUrl = try values.decodeIfPresent(String.self, forKey: .small_image_baseUrl)
		hotel_static_facilities_arr = try values.decodeIfPresent([Hotel_static_facilities_arr].self, forKey: .hotel_static_facilities_arr)
		hotel_static_contact_num = try values.decodeIfPresent([Hotel_static_contact_num].self, forKey: .hotel_static_contact_num)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		tokenKey = try values.decodeIfPresent(String.self, forKey: .tokenKey)
		min_price = try values.decodeIfPresent(Double.self, forKey: .min_price)

    }

}

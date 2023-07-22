

import Foundation
struct Hotel_static_facilities_arr : Codable {
	let additional_cost : String?
	let not_at_hotel : String?
	let hc : String?
	let fc : String?
	let dis_class : String?
	let fgc : String?
	let name : String?
	let icon_class : String?
	let facility_number : String?
	let cstr : String?

	enum CodingKeys: String, CodingKey {

		case additional_cost = "additional_cost"
		case not_at_hotel = "not_at_hotel"
		case hc = "hc"
		case fc = "fc"
		case dis_class = "dis_class"
		case fgc = "fgc"
		case name = "name"
		case icon_class = "icon_class"
		case facility_number = "facility_number"
		case cstr = "cstr"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		additional_cost = try values.decodeIfPresent(String.self, forKey: .additional_cost)
		not_at_hotel = try values.decodeIfPresent(String.self, forKey: .not_at_hotel)
		hc = try values.decodeIfPresent(String.self, forKey: .hc)
		fc = try values.decodeIfPresent(String.self, forKey: .fc)
		dis_class = try values.decodeIfPresent(String.self, forKey: .dis_class)
		fgc = try values.decodeIfPresent(String.self, forKey: .fgc)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		icon_class = try values.decodeIfPresent(String.self, forKey: .icon_class)
		facility_number = try values.decodeIfPresent(String.self, forKey: .facility_number)
		cstr = try values.decodeIfPresent(String.self, forKey: .cstr)
	}

}



import Foundation
struct Booking_itinerary_details : Codable {
	let origin : String?
	let app_reference : String?
	let airline_pnr : String?
	let segment_indicator : String?
	let airline_code : String?
	let airline_name : String?
	let flight_number : String?
	let fare_class : String?
	let from_airport_code : String?
	let from_airport_name : String?
	let to_airport_code : String?
	let to_airport_name : String?
	let departure_datetime : String?
	let arrival_datetime : String?
	let total_duration : String?
	let status : String?
	let operating_carrier : String?
	let fareRestriction : String?
	let fareBasisCode : String?
	let fareRuleDetail : String?
	let attributes : String?
	let segment_details : String?
	let cabin_baggage : String?
	let checkin_baggage : String?
	let is_refundable : String?
	let from_airport_terminal : String?
	let to_airport_terminal : String?
	let segment_raw_data : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case app_reference = "app_reference"
		case airline_pnr = "airline_pnr"
		case segment_indicator = "segment_indicator"
		case airline_code = "airline_code"
		case airline_name = "airline_name"
		case flight_number = "flight_number"
		case fare_class = "fare_class"
		case from_airport_code = "from_airport_code"
		case from_airport_name = "from_airport_name"
		case to_airport_code = "to_airport_code"
		case to_airport_name = "to_airport_name"
		case departure_datetime = "departure_datetime"
		case arrival_datetime = "arrival_datetime"
		case total_duration = "total_duration"
		case status = "status"
		case operating_carrier = "operating_carrier"
		case fareRestriction = "FareRestriction"
		case fareBasisCode = "FareBasisCode"
		case fareRuleDetail = "FareRuleDetail"
		case attributes = "attributes"
		case segment_details = "segment_details"
		case cabin_baggage = "cabin_baggage"
		case checkin_baggage = "checkin_baggage"
		case is_refundable = "is_refundable"
		case from_airport_terminal = "from_airport_terminal"
		case to_airport_terminal = "to_airport_terminal"
		case segment_raw_data = "segment_raw_data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
		airline_pnr = try values.decodeIfPresent(String.self, forKey: .airline_pnr)
		segment_indicator = try values.decodeIfPresent(String.self, forKey: .segment_indicator)
		airline_code = try values.decodeIfPresent(String.self, forKey: .airline_code)
		airline_name = try values.decodeIfPresent(String.self, forKey: .airline_name)
		flight_number = try values.decodeIfPresent(String.self, forKey: .flight_number)
		fare_class = try values.decodeIfPresent(String.self, forKey: .fare_class)
		from_airport_code = try values.decodeIfPresent(String.self, forKey: .from_airport_code)
		from_airport_name = try values.decodeIfPresent(String.self, forKey: .from_airport_name)
		to_airport_code = try values.decodeIfPresent(String.self, forKey: .to_airport_code)
		to_airport_name = try values.decodeIfPresent(String.self, forKey: .to_airport_name)
		departure_datetime = try values.decodeIfPresent(String.self, forKey: .departure_datetime)
		arrival_datetime = try values.decodeIfPresent(String.self, forKey: .arrival_datetime)
		total_duration = try values.decodeIfPresent(String.self, forKey: .total_duration)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		operating_carrier = try values.decodeIfPresent(String.self, forKey: .operating_carrier)
		fareRestriction = try values.decodeIfPresent(String.self, forKey: .fareRestriction)
		fareBasisCode = try values.decodeIfPresent(String.self, forKey: .fareBasisCode)
		fareRuleDetail = try values.decodeIfPresent(String.self, forKey: .fareRuleDetail)
		attributes = try values.decodeIfPresent(String.self, forKey: .attributes)
		segment_details = try values.decodeIfPresent(String.self, forKey: .segment_details)
		cabin_baggage = try values.decodeIfPresent(String.self, forKey: .cabin_baggage)
		checkin_baggage = try values.decodeIfPresent(String.self, forKey: .checkin_baggage)
		is_refundable = try values.decodeIfPresent(String.self, forKey: .is_refundable)
		from_airport_terminal = try values.decodeIfPresent(String.self, forKey: .from_airport_terminal)
		to_airport_terminal = try values.decodeIfPresent(String.self, forKey: .to_airport_terminal)
		segment_raw_data = try values.decodeIfPresent(String.self, forKey: .segment_raw_data)
	}

}

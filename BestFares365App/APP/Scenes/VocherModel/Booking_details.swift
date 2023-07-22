
import Foundation
struct Booking_details : Codable {
	let origin : String?
	let domain_origin : String?
	let status : String?
	let app_reference : String?
	let booking_source : String?
	let trip_type : String?
	let phone : String?
	let phone_code : String?
	let alternate_phone_code : String?
	let alternate_number : String?
	let email : String?
	let journey_start : String?
	let journey_end : String?
	let journey_from : String?
	let journey_to : String?
	let from_loc : String?
	let to_loc : String?
	let payment_mode : String?
	let convinence_value : String?
	let convinence_value_type : String?
	let convinence_per_pax : String?
	let convinence_amount : String?
	let discount : String?
	let currency : String?
	let currency_conversion_rate : String?
	let attributes : String?
	let seg_attributes : String?
	let seat_no : String?
	let created_by_id : String?
	let created_datetime : String?
	let seat_attributes : String?
	let res_attributes : String?
	let booking_billing_type : String?
	let work_assigned_to : String?
	let promocode : String?
	let trip_type_label : String?
	let pnr : String?
	let fare : Int?
	let admin_commission : Int?
	let agent_commission : Int?
	let admin_markup : Int?
	let agent_markup : Int?
	let agent_tds_on_commission : Int?
	let admin_buying_price : Int?
	let agent_buying_price : Int?
	let grand_total : Int?
	let cutomer_city : String?
	let cutomer_zipcode : String?
	let cutomer_address : String?
	let cutomer_country : String?
	let lead_pax_name : String?
	let lead_pax_phone_number : String?
	let lead_pax_email : String?
	let domain_name : String?
	let domain_ip : String?
	let domain_key : String?
	let theme_id : String?
	let domain_logo : String?
	let booked_date : String?
	let booking_itinerary_details : [Booking_itinerary_details]?
	let booking_transaction_details : [Booking_transaction_details]?
	let customer_details : [Customer_details]?
	let cancellation_details : [Cancellation_details]?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case domain_origin = "domain_origin"
		case status = "status"
		case app_reference = "app_reference"
		case booking_source = "booking_source"
		case trip_type = "trip_type"
		case phone = "phone"
		case phone_code = "phone_code"
		case alternate_phone_code = "alternate_phone_code"
		case alternate_number = "alternate_number"
		case email = "email"
		case journey_start = "journey_start"
		case journey_end = "journey_end"
		case journey_from = "journey_from"
		case journey_to = "journey_to"
		case from_loc = "from_loc"
		case to_loc = "to_loc"
		case payment_mode = "payment_mode"
		case convinence_value = "convinence_value"
		case convinence_value_type = "convinence_value_type"
		case convinence_per_pax = "convinence_per_pax"
		case convinence_amount = "convinence_amount"
		case discount = "discount"
		case currency = "currency"
		case currency_conversion_rate = "currency_conversion_rate"
		case attributes = "attributes"
		case seg_attributes = "seg_attributes"
		case seat_no = "seat_no"
		case created_by_id = "created_by_id"
		case created_datetime = "created_datetime"
		case seat_attributes = "seat_attributes"
		case res_attributes = "res_attributes"
		case booking_billing_type = "booking_billing_type"
		case work_assigned_to = "work_assigned_to"
		case promocode = "promocode"
		case trip_type_label = "trip_type_label"
		case pnr = "pnr"
		case fare = "fare"
		case admin_commission = "admin_commission"
		case agent_commission = "agent_commission"
		case admin_markup = "admin_markup"
		case agent_markup = "agent_markup"
		case agent_tds_on_commission = "agent_tds_on_commission"
		case admin_buying_price = "admin_buying_price"
		case agent_buying_price = "agent_buying_price"
		case grand_total = "grand_total"
		case cutomer_city = "cutomer_city"
		case cutomer_zipcode = "cutomer_zipcode"
		case cutomer_address = "cutomer_address"
		case cutomer_country = "cutomer_country"
		case lead_pax_name = "lead_pax_name"
		case lead_pax_phone_number = "lead_pax_phone_number"
		case lead_pax_email = "lead_pax_email"
		case domain_name = "domain_name"
		case domain_ip = "domain_ip"
		case domain_key = "domain_key"
		case theme_id = "theme_id"
		case domain_logo = "domain_logo"
		case booked_date = "booked_date"
		case booking_itinerary_details = "booking_itinerary_details"
		case booking_transaction_details = "booking_transaction_details"
		case customer_details = "customer_details"
		case cancellation_details = "cancellation_details"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		domain_origin = try values.decodeIfPresent(String.self, forKey: .domain_origin)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
		booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
		trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		phone_code = try values.decodeIfPresent(String.self, forKey: .phone_code)
		alternate_phone_code = try values.decodeIfPresent(String.self, forKey: .alternate_phone_code)
		alternate_number = try values.decodeIfPresent(String.self, forKey: .alternate_number)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		journey_start = try values.decodeIfPresent(String.self, forKey: .journey_start)
		journey_end = try values.decodeIfPresent(String.self, forKey: .journey_end)
		journey_from = try values.decodeIfPresent(String.self, forKey: .journey_from)
		journey_to = try values.decodeIfPresent(String.self, forKey: .journey_to)
		from_loc = try values.decodeIfPresent(String.self, forKey: .from_loc)
		to_loc = try values.decodeIfPresent(String.self, forKey: .to_loc)
		payment_mode = try values.decodeIfPresent(String.self, forKey: .payment_mode)
		convinence_value = try values.decodeIfPresent(String.self, forKey: .convinence_value)
		convinence_value_type = try values.decodeIfPresent(String.self, forKey: .convinence_value_type)
		convinence_per_pax = try values.decodeIfPresent(String.self, forKey: .convinence_per_pax)
		convinence_amount = try values.decodeIfPresent(String.self, forKey: .convinence_amount)
		discount = try values.decodeIfPresent(String.self, forKey: .discount)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		currency_conversion_rate = try values.decodeIfPresent(String.self, forKey: .currency_conversion_rate)
		attributes = try values.decodeIfPresent(String.self, forKey: .attributes)
		seg_attributes = try values.decodeIfPresent(String.self, forKey: .seg_attributes)
		seat_no = try values.decodeIfPresent(String.self, forKey: .seat_no)
		created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
		created_datetime = try values.decodeIfPresent(String.self, forKey: .created_datetime)
		seat_attributes = try values.decodeIfPresent(String.self, forKey: .seat_attributes)
		res_attributes = try values.decodeIfPresent(String.self, forKey: .res_attributes)
		booking_billing_type = try values.decodeIfPresent(String.self, forKey: .booking_billing_type)
		work_assigned_to = try values.decodeIfPresent(String.self, forKey: .work_assigned_to)
		promocode = try values.decodeIfPresent(String.self, forKey: .promocode)
		trip_type_label = try values.decodeIfPresent(String.self, forKey: .trip_type_label)
		pnr = try values.decodeIfPresent(String.self, forKey: .pnr)
		fare = try values.decodeIfPresent(Int.self, forKey: .fare)
		admin_commission = try values.decodeIfPresent(Int.self, forKey: .admin_commission)
		agent_commission = try values.decodeIfPresent(Int.self, forKey: .agent_commission)
		admin_markup = try values.decodeIfPresent(Int.self, forKey: .admin_markup)
		agent_markup = try values.decodeIfPresent(Int.self, forKey: .agent_markup)
		agent_tds_on_commission = try values.decodeIfPresent(Int.self, forKey: .agent_tds_on_commission)
		admin_buying_price = try values.decodeIfPresent(Int.self, forKey: .admin_buying_price)
		agent_buying_price = try values.decodeIfPresent(Int.self, forKey: .agent_buying_price)
		grand_total = try values.decodeIfPresent(Int.self, forKey: .grand_total)
		cutomer_city = try values.decodeIfPresent(String.self, forKey: .cutomer_city)
		cutomer_zipcode = try values.decodeIfPresent(String.self, forKey: .cutomer_zipcode)
		cutomer_address = try values.decodeIfPresent(String.self, forKey: .cutomer_address)
		cutomer_country = try values.decodeIfPresent(String.self, forKey: .cutomer_country)
		lead_pax_name = try values.decodeIfPresent(String.self, forKey: .lead_pax_name)
		lead_pax_phone_number = try values.decodeIfPresent(String.self, forKey: .lead_pax_phone_number)
		lead_pax_email = try values.decodeIfPresent(String.self, forKey: .lead_pax_email)
		domain_name = try values.decodeIfPresent(String.self, forKey: .domain_name)
		domain_ip = try values.decodeIfPresent(String.self, forKey: .domain_ip)
		domain_key = try values.decodeIfPresent(String.self, forKey: .domain_key)
		theme_id = try values.decodeIfPresent(String.self, forKey: .theme_id)
		domain_logo = try values.decodeIfPresent(String.self, forKey: .domain_logo)
		booked_date = try values.decodeIfPresent(String.self, forKey: .booked_date)
		booking_itinerary_details = try values.decodeIfPresent([Booking_itinerary_details].self, forKey: .booking_itinerary_details)
		booking_transaction_details = try values.decodeIfPresent([Booking_transaction_details].self, forKey: .booking_transaction_details)
		customer_details = try values.decodeIfPresent([Customer_details].self, forKey: .customer_details)
		cancellation_details = try values.decodeIfPresent([Cancellation_details].self, forKey: .cancellation_details)
	}

}

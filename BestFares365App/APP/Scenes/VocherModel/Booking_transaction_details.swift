

import Foundation
struct Booking_transaction_details : Codable {
	let origin : String?
	let app_reference : String?
	let pnr : String?
	let status : String?
	let status_description : String?
	let book_id : String?
	let source : String?
	let ref_id : String?
	let total_fare : String?
	let admin_commission : String?
	let agent_commission : String?
	let admin_tds : String?
	let agent_tds : String?
	let admin_markup : String?
	let agent_markup : String?
	let ait : String?
	let currency : String?
	let getbooking_StatusCode : String?
	let getbooking_Description : String?
	let getbooking_Category : String?
	let attributes : String?
	let sequence_number : String?
	let hold_ticket_req_status : String?
	let booking_currency : String?
	let booking_amount : String?
	let sms_charge : String?
	let charity_charge : String?
	let checkin_charge : String?
	let extra_bag_charge : String?
	let payment_method : String?
	let booking_class : String?
	let seat_charge : String?
	let ticket_number : String?
	let booking_customer_details : [Booking_customer_details]?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case app_reference = "app_reference"
		case pnr = "pnr"
		case status = "status"
		case status_description = "status_description"
		case book_id = "book_id"
		case source = "source"
		case ref_id = "ref_id"
		case total_fare = "total_fare"
		case admin_commission = "admin_commission"
		case agent_commission = "agent_commission"
		case admin_tds = "admin_tds"
		case agent_tds = "agent_tds"
		case admin_markup = "admin_markup"
		case agent_markup = "agent_markup"
		case ait = "ait"
		case currency = "currency"
		case getbooking_StatusCode = "getbooking_StatusCode"
		case getbooking_Description = "getbooking_Description"
		case getbooking_Category = "getbooking_Category"
		case attributes = "attributes"
		case sequence_number = "sequence_number"
		case hold_ticket_req_status = "hold_ticket_req_status"
		case booking_currency = "booking_currency"
		case booking_amount = "booking_amount"
		case sms_charge = "sms_charge"
		case charity_charge = "charity_charge"
		case checkin_charge = "checkin_charge"
		case extra_bag_charge = "extra_bag_charge"
		case payment_method = "payment_method"
		case booking_class = "booking_class"
		case seat_charge = "seat_charge"
		case ticket_number = "ticket_number"
		case booking_customer_details = "booking_customer_details"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
		pnr = try values.decodeIfPresent(String.self, forKey: .pnr)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		status_description = try values.decodeIfPresent(String.self, forKey: .status_description)
		book_id = try values.decodeIfPresent(String.self, forKey: .book_id)
		source = try values.decodeIfPresent(String.self, forKey: .source)
		ref_id = try values.decodeIfPresent(String.self, forKey: .ref_id)
		total_fare = try values.decodeIfPresent(String.self, forKey: .total_fare)
		admin_commission = try values.decodeIfPresent(String.self, forKey: .admin_commission)
		agent_commission = try values.decodeIfPresent(String.self, forKey: .agent_commission)
		admin_tds = try values.decodeIfPresent(String.self, forKey: .admin_tds)
		agent_tds = try values.decodeIfPresent(String.self, forKey: .agent_tds)
		admin_markup = try values.decodeIfPresent(String.self, forKey: .admin_markup)
		agent_markup = try values.decodeIfPresent(String.self, forKey: .agent_markup)
		ait = try values.decodeIfPresent(String.self, forKey: .ait)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		getbooking_StatusCode = try values.decodeIfPresent(String.self, forKey: .getbooking_StatusCode)
		getbooking_Description = try values.decodeIfPresent(String.self, forKey: .getbooking_Description)
		getbooking_Category = try values.decodeIfPresent(String.self, forKey: .getbooking_Category)
		attributes = try values.decodeIfPresent(String.self, forKey: .attributes)
		sequence_number = try values.decodeIfPresent(String.self, forKey: .sequence_number)
		hold_ticket_req_status = try values.decodeIfPresent(String.self, forKey: .hold_ticket_req_status)
		booking_currency = try values.decodeIfPresent(String.self, forKey: .booking_currency)
		booking_amount = try values.decodeIfPresent(String.self, forKey: .booking_amount)
		sms_charge = try values.decodeIfPresent(String.self, forKey: .sms_charge)
		charity_charge = try values.decodeIfPresent(String.self, forKey: .charity_charge)
		checkin_charge = try values.decodeIfPresent(String.self, forKey: .checkin_charge)
		extra_bag_charge = try values.decodeIfPresent(String.self, forKey: .extra_bag_charge)
		payment_method = try values.decodeIfPresent(String.self, forKey: .payment_method)
		booking_class = try values.decodeIfPresent(String.self, forKey: .booking_class)
		seat_charge = try values.decodeIfPresent(String.self, forKey: .seat_charge)
		ticket_number = try values.decodeIfPresent(String.self, forKey: .ticket_number)
		booking_customer_details = try values.decodeIfPresent([Booking_customer_details].self, forKey: .booking_customer_details)
	}

}

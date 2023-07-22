/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Booking_customer_details : Codable {
	let origin : String?
	let app_reference : String?
	let flight_booking_transaction_details_fk : String?
	let passenger_type : String?
	let is_lead : String?
	let title : String?
	let first_name : String?
	let middle_name : String?
	let last_name : String?
	let date_of_birth : String?
	let gender : String?
	let passenger_nationality : String?
	let passport_number : String?
	let passport_issuing_country : String?
	let passport_expiry_date : String?
	let ffnumber : String?
	let status : String?
	let mealcode : String?
	let adult_special_assistance : String?
	let attributes : String?
	let ticketId : String?
	let ticketNumber : String?
	let issueDate : String?
	let fare : String?
	let segmentAdditionalInfo : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case app_reference = "app_reference"
		case flight_booking_transaction_details_fk = "flight_booking_transaction_details_fk"
		case passenger_type = "passenger_type"
		case is_lead = "is_lead"
		case title = "title"
		case first_name = "first_name"
		case middle_name = "middle_name"
		case last_name = "last_name"
		case date_of_birth = "date_of_birth"
		case gender = "gender"
		case passenger_nationality = "passenger_nationality"
		case passport_number = "passport_number"
		case passport_issuing_country = "passport_issuing_country"
		case passport_expiry_date = "passport_expiry_date"
		case ffnumber = "ffnumber"
		case status = "status"
		case mealcode = "mealcode"
		case adult_special_assistance = "adult_special_assistance"
		case attributes = "attributes"
		case ticketId = "TicketId"
		case ticketNumber = "TicketNumber"
		case issueDate = "IssueDate"
		case fare = "Fare"
		case segmentAdditionalInfo = "SegmentAdditionalInfo"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
		flight_booking_transaction_details_fk = try values.decodeIfPresent(String.self, forKey: .flight_booking_transaction_details_fk)
		passenger_type = try values.decodeIfPresent(String.self, forKey: .passenger_type)
		is_lead = try values.decodeIfPresent(String.self, forKey: .is_lead)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
		middle_name = try values.decodeIfPresent(String.self, forKey: .middle_name)
		last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
		date_of_birth = try values.decodeIfPresent(String.self, forKey: .date_of_birth)
		gender = try values.decodeIfPresent(String.self, forKey: .gender)
		passenger_nationality = try values.decodeIfPresent(String.self, forKey: .passenger_nationality)
		passport_number = try values.decodeIfPresent(String.self, forKey: .passport_number)
		passport_issuing_country = try values.decodeIfPresent(String.self, forKey: .passport_issuing_country)
		passport_expiry_date = try values.decodeIfPresent(String.self, forKey: .passport_expiry_date)
		ffnumber = try values.decodeIfPresent(String.self, forKey: .ffnumber)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		mealcode = try values.decodeIfPresent(String.self, forKey: .mealcode)
		adult_special_assistance = try values.decodeIfPresent(String.self, forKey: .adult_special_assistance)
		attributes = try values.decodeIfPresent(String.self, forKey: .attributes)
		ticketId = try values.decodeIfPresent(String.self, forKey: .ticketId)
		ticketNumber = try values.decodeIfPresent(String.self, forKey: .ticketNumber)
		issueDate = try values.decodeIfPresent(String.self, forKey: .issueDate)
		fare = try values.decodeIfPresent(String.self, forKey: .fare)
		segmentAdditionalInfo = try values.decodeIfPresent(String.self, forKey: .segmentAdditionalInfo)
	}

}
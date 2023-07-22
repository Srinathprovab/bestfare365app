

import Foundation
struct Pre_booking_summery : Codable {
	let fareDetails : FareDetails?
	let passengerFareBreakdown : PassengerFareBreakdown?
	let segmentDetails : [[SegmentDetails]]?
	let segmentSummary : [SegmentSummary]?
	let holdTicket : Bool?
	let admin_markup_detail : Int?

	enum CodingKeys: String, CodingKey {

		case fareDetails = "FareDetails"
		case passengerFareBreakdown = "PassengerFareBreakdown"
		case segmentDetails = "SegmentDetails"
		case segmentSummary = "SegmentSummary"
		case holdTicket = "HoldTicket"
		case admin_markup_detail = "admin_markup_detail"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		fareDetails = try values.decodeIfPresent(FareDetails.self, forKey: .fareDetails)
		passengerFareBreakdown = try values.decodeIfPresent(PassengerFareBreakdown.self, forKey: .passengerFareBreakdown)
		segmentDetails = try values.decodeIfPresent([[SegmentDetails]].self, forKey: .segmentDetails)
		segmentSummary = try values.decodeIfPresent([SegmentSummary].self, forKey: .segmentSummary)
		holdTicket = try values.decodeIfPresent(Bool.self, forKey: .holdTicket)
		admin_markup_detail = try values.decodeIfPresent(Int.self, forKey: .admin_markup_detail)
	}

}

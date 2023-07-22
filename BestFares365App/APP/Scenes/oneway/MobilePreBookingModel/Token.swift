
import Foundation
struct Token : Codable {
	let airlineRemark : String?
	let fareDetails : FareDetails?
	let passengerFareBreakdown : PassengerFareBreakdown?
	let segmentDetails : [[SegmentDetails]]?
	let booking_source : String?
	let holdTicket : Bool?
	let provabAuthKey : String?

	enum CodingKeys: String, CodingKey {

		case airlineRemark = "AirlineRemark"
		case fareDetails = "FareDetails"
		case passengerFareBreakdown = "PassengerFareBreakdown"
		case segmentDetails = "SegmentDetails"
		case booking_source = "booking_source"
		case holdTicket = "HoldTicket"
		case provabAuthKey = "ProvabAuthKey"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		airlineRemark = try values.decodeIfPresent(String.self, forKey: .airlineRemark)
		fareDetails = try values.decodeIfPresent(FareDetails.self, forKey: .fareDetails)
		passengerFareBreakdown = try values.decodeIfPresent(PassengerFareBreakdown.self, forKey: .passengerFareBreakdown)
		segmentDetails = try values.decodeIfPresent([[SegmentDetails]].self, forKey: .segmentDetails)
		booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
		holdTicket = try values.decodeIfPresent(Bool.self, forKey: .holdTicket)
		provabAuthKey = try values.decodeIfPresent(String.self, forKey: .provabAuthKey)
	}

}

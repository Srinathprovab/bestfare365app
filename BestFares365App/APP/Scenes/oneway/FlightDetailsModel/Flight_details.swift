
import Foundation
struct FDFlight_details : Codable {
	let baggage : String?
	let cabinBaggage : String?
	let airlineDetails : FDAirlineDetails?
	let originDetails : FDOriginDetails?
	let destinationDetails : FDDestinationDetails?
	let segmentDuration : String?

	enum CodingKeys: String, CodingKey {

		case baggage = "Baggage"
		case cabinBaggage = "CabinBaggage"
		case airlineDetails = "AirlineDetails"
		case originDetails = "OriginDetails"
		case destinationDetails = "DestinationDetails"
		case segmentDuration = "SegmentDuration"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		baggage = try values.decodeIfPresent(String.self, forKey: .baggage)
		cabinBaggage = try values.decodeIfPresent(String.self, forKey: .cabinBaggage)
		airlineDetails = try values.decodeIfPresent(FDAirlineDetails.self, forKey: .airlineDetails)
		originDetails = try values.decodeIfPresent(FDOriginDetails.self, forKey: .originDetails)
		destinationDetails = try values.decodeIfPresent(FDDestinationDetails.self, forKey: .destinationDetails)
		segmentDuration = try values.decodeIfPresent(String.self, forKey: .segmentDuration)
	}

}

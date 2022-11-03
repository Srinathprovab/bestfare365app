

import Foundation
struct SegmentSummary : Codable {
    
	let airlineDetails : AirlineDetails?
	let originDetails : OriginDetails?
	let destinationDetails : DestinationDetails?
	let totalStops : Int?
	let totalDuaration : String?

	enum CodingKeys: String, CodingKey {

		case airlineDetails = "AirlineDetails"
		case originDetails = "OriginDetails"
		case destinationDetails = "DestinationDetails"
		case totalStops = "TotalStops"
		case totalDuaration = "TotalDuaration"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		airlineDetails = try values.decodeIfPresent(AirlineDetails.self, forKey: .airlineDetails)
    originDetails = try values.decodeIfPresent(OriginDetails.self, forKey: .originDetails)
		destinationDetails = try values.decodeIfPresent(DestinationDetails.self, forKey: .destinationDetails)
		totalStops = try values.decodeIfPresent(Int.self, forKey: .totalStops)
		totalDuaration = try values.decodeIfPresent(String.self, forKey: .totalDuaration)
	}

}

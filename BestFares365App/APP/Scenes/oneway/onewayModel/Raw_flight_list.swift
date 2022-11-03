

import Foundation
struct Raw_flight_list : Codable {
    
	//let journeySummary : JourneySummary?
	let flights : [[Flights]]?

	enum CodingKeys: String, CodingKey {

	//	case journeySummary = "JourneySummary"
		case flights = "Flights"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
	//	journeySummary = try values.decodeIfPresent(JourneySummary.self, forKey: .journeySummary)
		flights = try values.decodeIfPresent([[Flights]].self, forKey: .flights)
	}

}

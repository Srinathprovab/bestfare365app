
import Foundation
struct FDAirlineDetails : Codable {
	let airlineCode : String?
	let airlineName : String?
	let flightNumber : String?
	let fareClass : String?

	enum CodingKeys: String, CodingKey {

		case airlineCode = "AirlineCode"
		case airlineName = "AirlineName"
		case flightNumber = "FlightNumber"
		case fareClass = "FareClass"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		airlineCode = try values.decodeIfPresent(String.self, forKey: .airlineCode)
		airlineName = try values.decodeIfPresent(String.self, forKey: .airlineName)
		flightNumber = try values.decodeIfPresent(String.self, forKey: .flightNumber)
		fareClass = try values.decodeIfPresent(String.self, forKey: .fareClass)
	}

}

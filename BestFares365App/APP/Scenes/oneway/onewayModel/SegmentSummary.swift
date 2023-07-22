

import Foundation
struct SegmentSummary : Codable {
    let airlineDetails : AirlineDetails?
    let originDetails : OriginDetails?
    let destinationDetails : DestinationDetails?
    let totalStops : Int?
    let flight_result_value : String?
    let totalDuaration : String?
    let seatLeft : Int?

    enum CodingKeys: String, CodingKey {

        case airlineDetails = "AirlineDetails"
        case originDetails = "OriginDetails"
        case destinationDetails = "DestinationDetails"
        case totalStops = "TotalStops"
        case flight_result_value = "flight_result_value"
        case totalDuaration = "TotalDuaration"
        case seatLeft = "seatLeft"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airlineDetails = try values.decodeIfPresent(AirlineDetails.self, forKey: .airlineDetails)
        originDetails = try values.decodeIfPresent(OriginDetails.self, forKey: .originDetails)
        destinationDetails = try values.decodeIfPresent(DestinationDetails.self, forKey: .destinationDetails)
        totalStops = try values.decodeIfPresent(Int.self, forKey: .totalStops)
        flight_result_value = try values.decodeIfPresent(String.self, forKey: .flight_result_value)
        totalDuaration = try values.decodeIfPresent(String.self, forKey: .totalDuaration)
        seatLeft = try values.decodeIfPresent(Int.self, forKey: .seatLeft)
    }

}

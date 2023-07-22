

import Foundation
struct Flights : Codable {
    let airlineRemark : String?
    let fareDetails : FareDetails?
    let passengerFareBreakdown : PassengerFareBreakdown?
    let segmentSummary : [SegmentSummary]?
    let booking_source : String?
    let holdTicket : Bool?
    let token : String?
    let provabAuthKey : String?
    let tokenKey : String?
    let selectedResult : Int?
    let seatLeft : [Int]?

    enum CodingKeys: String, CodingKey {

        case airlineRemark = "AirlineRemark"
        case fareDetails = "FareDetails"
        case passengerFareBreakdown = "PassengerFareBreakdown"
        case segmentSummary = "SegmentSummary"
        case booking_source = "booking_source"
        case holdTicket = "HoldTicket"
        case token = "Token"
        case provabAuthKey = "ProvabAuthKey"
        case tokenKey = "TokenKey"
        case selectedResult = "selectedResult"
        case seatLeft = "seatLeft"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airlineRemark = try values.decodeIfPresent(String.self, forKey: .airlineRemark)
        fareDetails = try values.decodeIfPresent(FareDetails.self, forKey: .fareDetails)
        passengerFareBreakdown = try values.decodeIfPresent(PassengerFareBreakdown.self, forKey: .passengerFareBreakdown)
        segmentSummary = try values.decodeIfPresent([SegmentSummary].self, forKey: .segmentSummary)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        holdTicket = try values.decodeIfPresent(Bool.self, forKey: .holdTicket)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        provabAuthKey = try values.decodeIfPresent(String.self, forKey: .provabAuthKey)
        tokenKey = try values.decodeIfPresent(String.self, forKey: .tokenKey)
        selectedResult = try values.decodeIfPresent(Int.self, forKey: .selectedResult)
        seatLeft = try values.decodeIfPresent([Int].self, forKey: .seatLeft)
    }

}

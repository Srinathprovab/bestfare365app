

import Foundation
struct Flights : Codable {
    let airlineRemark : String?
    let fareDetails : FareDetails?
    //    let passengerFareBreakdown : PassengerFareBreakdown?
    let segmentSummary : [SegmentSummary]?
    let segmentDetails : [[SegmentDetails]]?
    let booking_source : String?
    let holdTicket : Bool?
    let token : String?
    let provabAuthKey : String?
    let tokenKey : String?
    
    enum CodingKeys: String, CodingKey {
        
        case airlineRemark = "AirlineRemark"
        case fareDetails = "FareDetails"
        //        case passengerFareBreakdown = "PassengerFareBreakdown"
        case segmentSummary = "SegmentSummary"
        case segmentDetails = "SegmentDetails"
        case booking_source = "booking_source"
        case holdTicket = "HoldTicket"
        case token = "Token"
        case provabAuthKey = "ProvabAuthKey"
        case tokenKey = "TokenKey"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airlineRemark = try values.decodeIfPresent(String.self, forKey: .airlineRemark)
        fareDetails = try values.decodeIfPresent(FareDetails.self, forKey: .fareDetails)
        //        passengerFareBreakdown = try values.decodeIfPresent(PassengerFareBreakdown.self, forKey: .passengerFareBreakdown)
        segmentSummary = try values.decodeIfPresent([SegmentSummary].self, forKey: .segmentSummary)
        segmentDetails = try values.decodeIfPresent([[SegmentDetails]].self, forKey: .segmentDetails)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        holdTicket = try values.decodeIfPresent(Bool.self, forKey: .holdTicket)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        provabAuthKey = try values.decodeIfPresent(String.self, forKey: .provabAuthKey)
        tokenKey = try values.decodeIfPresent(String.self, forKey: .tokenKey)
    }
    
}


import Foundation
struct ItinearyDet : Codable {
    let baggage : String?
    let cabinBaggage : String?
    let airlineDetails : AirlineDetails?
    let originDetails : OriginDetails?
    let destinationDetails : DestinationDetails?
    let segmentDuration : String?
    let waitingTime : String?
    let stops : Int?
    let fare : ItinearyDetFare?

    enum CodingKeys: String, CodingKey {

        case baggage = "Baggage"
        case cabinBaggage = "CabinBaggage"
        case airlineDetails = "AirlineDetails"
        case originDetails = "OriginDetails"
        case destinationDetails = "DestinationDetails"
        case segmentDuration = "SegmentDuration"
        case waitingTime = "WaitingTime"
        case stops = "stops"
        case fare = "Fare"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        baggage = try values.decodeIfPresent(String.self, forKey: .baggage)
        cabinBaggage = try values.decodeIfPresent(String.self, forKey: .cabinBaggage)
        airlineDetails = try values.decodeIfPresent(AirlineDetails.self, forKey: .airlineDetails)
        originDetails = try values.decodeIfPresent(OriginDetails.self, forKey: .originDetails)
        destinationDetails = try values.decodeIfPresent(DestinationDetails.self, forKey: .destinationDetails)
        segmentDuration = try values.decodeIfPresent(String.self, forKey: .segmentDuration)
        waitingTime = try values.decodeIfPresent(String.self, forKey: .waitingTime)
        stops = try values.decodeIfPresent(Int.self, forKey: .stops)
        fare = try values.decodeIfPresent(ItinearyDetFare.self, forKey: .fare)
    }

}


import Foundation
struct FDFlight_details : Codable {
    
    let baggage : String?
    let cabinBaggage : String?
    let airlineDetails : FDAirlineDetails?
    let originDetails : FDOriginDetails?
    let destinationDetails : FDDestinationDetails?
    let segmentDuration : String?
    let waitingTime : String?
    let location : String?
    let equipmentType : String?
    let meal : String?
    let seat_pitch : String?
    let power_usb : String?

    enum CodingKeys: String, CodingKey {

        case baggage = "Baggage"
        case cabinBaggage = "CabinBaggage"
        case airlineDetails = "AirlineDetails"
        case originDetails = "OriginDetails"
        case destinationDetails = "DestinationDetails"
        case segmentDuration = "SegmentDuration"
        case waitingTime = "WaitingTime"
        case location = "location"
        case equipmentType = "equipmentType"
        case meal = "meal"
        case seat_pitch = "seat_pitch"
        case power_usb = "power_usb"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        baggage = try values.decodeIfPresent(String.self, forKey: .baggage)
        cabinBaggage = try values.decodeIfPresent(String.self, forKey: .cabinBaggage)
        airlineDetails = try values.decodeIfPresent(FDAirlineDetails.self, forKey: .airlineDetails)
        originDetails = try values.decodeIfPresent(FDOriginDetails.self, forKey: .originDetails)
        destinationDetails = try values.decodeIfPresent(FDDestinationDetails.self, forKey: .destinationDetails)
        segmentDuration = try values.decodeIfPresent(String.self, forKey: .segmentDuration)
        waitingTime = try values.decodeIfPresent(String.self, forKey: .waitingTime)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        equipmentType = try values.decodeIfPresent(String.self, forKey: .equipmentType)
        meal = try values.decodeIfPresent(String.self, forKey: .meal)
        seat_pitch = try values.decodeIfPresent(String.self, forKey: .seat_pitch)
        power_usb = try values.decodeIfPresent(String.self, forKey: .power_usb)
    }

}

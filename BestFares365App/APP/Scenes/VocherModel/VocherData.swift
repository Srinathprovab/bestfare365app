//
//  VocherData.swift
//  BestFares365App
//
//  Created by FCI on 13/03/23.
//

import Foundation

struct VocherData : Codable {
    
    let booking_details : [Booking_details]?
    let traveller_details : [Vocher_Traveller_details]?
    let address : String?
    let phone : String?
    let domainname : String?
    let logo : String?
    let seat_details : String?
    let itinearyDet : [[ItinearyDet]]?

    enum CodingKeys: String, CodingKey {

        case booking_details = "booking_details"
        case traveller_details = "traveller_details"
        case address = "address"
        case phone = "phone"
        case domainname = "domainname"
        case logo = "logo"
        case seat_details = "seat_details"
        case itinearyDet = "itinearyDet"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_details = try values.decodeIfPresent([Booking_details].self, forKey: .booking_details)
        traveller_details = try values.decodeIfPresent([Vocher_Traveller_details].self, forKey: .traveller_details)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        domainname = try values.decodeIfPresent(String.self, forKey: .domainname)
        logo = try values.decodeIfPresent(String.self, forKey: .logo)
        seat_details = try values.decodeIfPresent(String.self, forKey: .seat_details)
        itinearyDet = try values.decodeIfPresent([[ItinearyDet]].self, forKey: .itinearyDet)
    }

}



struct Vocher_Traveller_details : Codable {
    
    let booking_passenger_id : String?
    let booking_global_id : String?
    let passenger_type : String?
    let first_name : String?
    let last_name : String?
    let dob : String?
    let age : String?
    let gender : String?
    let passport_no : String?
    let pass_expiry : String?
    let issue_country : String?
    let mealcode : String?
    let ssr_request : String?
    let frequent_flyer_no : String?
    let frequent_airline_code : String?
    let extra_baggage : String?
    let seat_selected : String?

    enum CodingKeys: String, CodingKey {

        case booking_passenger_id = "booking_passenger_id"
        case booking_global_id = "booking_global_id"
        case passenger_type = "passenger_type"
        case first_name = "first_name"
        case last_name = "last_name"
        case dob = "dob"
        case age = "age"
        case gender = "gender"
        case passport_no = "passport_no"
        case pass_expiry = "pass_expiry"
        case issue_country = "issue_country"
        case mealcode = "mealcode"
        case ssr_request = "ssr_request"
        case frequent_flyer_no = "frequent_flyer_no"
        case frequent_airline_code = "frequent_airline_code"
        case extra_baggage = "extra_baggage"
        case seat_selected = "seat_selected"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_passenger_id = try values.decodeIfPresent(String.self, forKey: .booking_passenger_id)
        booking_global_id = try values.decodeIfPresent(String.self, forKey: .booking_global_id)
        passenger_type = try values.decodeIfPresent(String.self, forKey: .passenger_type)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        passport_no = try values.decodeIfPresent(String.self, forKey: .passport_no)
        pass_expiry = try values.decodeIfPresent(String.self, forKey: .pass_expiry)
        issue_country = try values.decodeIfPresent(String.self, forKey: .issue_country)
        mealcode = try values.decodeIfPresent(String.self, forKey: .mealcode)
        ssr_request = try values.decodeIfPresent(String.self, forKey: .ssr_request)
        frequent_flyer_no = try values.decodeIfPresent(String.self, forKey: .frequent_flyer_no)
        frequent_airline_code = try values.decodeIfPresent(String.self, forKey: .frequent_airline_code)
        extra_baggage = try values.decodeIfPresent(String.self, forKey: .extra_baggage)
        seat_selected = try values.decodeIfPresent(String.self, forKey: .seat_selected)
    }

}

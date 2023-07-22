//
//  HMBPre_booking_params.swift
//  BestFares365App
//
//  Created by FCI on 27/03/23.
//

import Foundation

struct HMBPre_booking_params : Codable {
    let token : HMBToken?
    let search_id : String?
    let agent_markup : String?
    let admin_markup : String?
    let booking_source : String?
    let rateKey : [String]?
    let rooms : [String]?
    let childs : [String]?
    let adults : [String]?
    let room_configuration : Room_configuration?
    let default_currency : String?

    enum CodingKeys: String, CodingKey {

        case token = "token"
        case search_id = "search_id"
        case agent_markup = "agent_markup"
        case admin_markup = "admin_markup"
        case booking_source = "booking_source"
        case rateKey = "rateKey"
        case rooms = "rooms"
        case childs = "childs"
        case adults = "adults"
        case room_configuration = "room_configuration"
        case default_currency = "default_currency"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(HMBToken.self, forKey: .token)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        agent_markup = try values.decodeIfPresent(String.self, forKey: .agent_markup)
        admin_markup = try values.decodeIfPresent(String.self, forKey: .admin_markup)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        rateKey = try values.decodeIfPresent([String].self, forKey: .rateKey)
        rooms = try values.decodeIfPresent([String].self, forKey: .rooms)
        childs = try values.decodeIfPresent([String].self, forKey: .childs)
        adults = try values.decodeIfPresent([String].self, forKey: .adults)
        room_configuration = try values.decodeIfPresent(Room_configuration.self, forKey: .room_configuration)
        default_currency = try values.decodeIfPresent(String.self, forKey: .default_currency)
    }

}


struct HMBToken : Codable {
    let status : Bool?
    let data : HMBTokenData?
    let convenience_fees : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case convenience_fees = "convenience_fees"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(HMBTokenData.self, forKey: .data)
        convenience_fees = try values.decodeIfPresent(String.self, forKey: .convenience_fees)
    }

}

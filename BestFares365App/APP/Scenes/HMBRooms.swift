//
//  HMBRooms.swift
//  BestFares365App
//
//  Created by FCI on 13/06/23.
//

import Foundation

struct HMBRooms : Codable {
    let room_code : String?
    let room_name : String?
    let rates : [Rates]?

    enum CodingKeys: String, CodingKey {

        case room_code = "room_code"
        case room_name = "room_name"
        case rates = "rates"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        room_code = try values.decodeIfPresent(String.self, forKey: .room_code)
        room_name = try values.decodeIfPresent(String.self, forKey: .room_name)
        rates = try values.decodeIfPresent([Rates].self, forKey: .rates)
    }

}

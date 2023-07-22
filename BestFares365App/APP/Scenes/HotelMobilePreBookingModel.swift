//
//  HotelMobilePreBookingModel.swift
//  BestFares365App
//
//  Created by FCI on 13/06/23.
//

import Foundation


struct HotelMobilePreBookingModel : Codable {
    let status : Int?
    let msg : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}

//
//  MobilePreBookingModel.swift
//  BestFares365App
//
//  Created by FCI on 15/02/23.
//

import Foundation


struct MobilePreBookingModel : Codable {
    let status : Bool?
    let data : MPBData?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(MPBData.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}

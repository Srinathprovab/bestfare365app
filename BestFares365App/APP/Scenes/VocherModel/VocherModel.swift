//
//  VocherModel.swift
//  BestFares365App
//
//  Created by FCI on 13/03/23.
//

import Foundation

import Foundation
struct VocherModel : Codable {
    let data : VocherData?
    let status : Bool?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(VocherData.self, forKey: .data)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}

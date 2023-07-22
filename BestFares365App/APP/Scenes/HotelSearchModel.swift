//
//  HotelSearchModel.swift
//  BestFares365App
//
//  Created by FCI on 14/03/23.
//

import Foundation


struct HotelSearchModel : Codable {
    
    let data : HotelData?
    let msg : String?
    let status : Int?
    let total_result_count : Int?
    let filter_result_count : Int?
    let offset : Int?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
        case total_result_count = "total_result_count"
        case filter_result_count = "filter_result_count"
        case offset = "offset"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(HotelData.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        total_result_count = try values.decodeIfPresent(Int.self, forKey: .total_result_count)
        filter_result_count = try values.decodeIfPresent(Int.self, forKey: .filter_result_count)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
    }

}

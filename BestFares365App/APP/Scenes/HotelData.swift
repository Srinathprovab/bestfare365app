//
//  HotelData.swift
//  BestFares365App
//
//  Created by FCI on 14/03/23.
//

import Foundation


struct HotelData : Codable {
    let raw_hotel_list : [Raw_hotel_list]?
    let search_id : Int?
    let booking_source : String?
    let view_type : String?
    let no_of_nights : Int?

    enum CodingKeys: String, CodingKey {

        case raw_hotel_list = "raw_hotel_list"
        case search_id = "search_id"
        case booking_source = "booking_source"
        case view_type = "view_type"
        case no_of_nights = "no_of_nights"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        raw_hotel_list = try values.decodeIfPresent([Raw_hotel_list].self, forKey: .raw_hotel_list)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        view_type = try values.decodeIfPresent(String.self, forKey: .view_type)
        no_of_nights = try values.decodeIfPresent(Int.self, forKey: .no_of_nights)
    }

}

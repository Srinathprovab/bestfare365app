//
//  HotelDetailsModel.swift
//  BestFares365App
//
//  Created by FCI on 16/03/23.
//

import Foundation



struct HotelDetailsModel : Codable {
    
    let currency_obj : Currency_obj?
    let hotel_details : Hotel_details?
    let trip_hotel_code : String?
    let params : Params?
    let star_rating_htl : Int?
    let new_hotel_address : String?
    let session_expiry_details : Session_expiry_details?
    
    enum CodingKeys: String, CodingKey {
        
        case currency_obj = "currency_obj"
        case hotel_details = "hotel_details"
        case trip_hotel_code = "trip_hotel_code"
        case params = "params"
        case star_rating_htl = "star_rating_htl"
        case new_hotel_address = "new_hotel_address"
        case session_expiry_details = "session_expiry_details"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currency_obj = try values.decodeIfPresent(Currency_obj.self, forKey: .currency_obj)
        hotel_details = try values.decodeIfPresent(Hotel_details.self, forKey: .hotel_details)
        trip_hotel_code = try values.decodeIfPresent(String.self, forKey: .trip_hotel_code)
        params = try values.decodeIfPresent(Params.self, forKey: .params)
        star_rating_htl = try values.decodeIfPresent(Int.self, forKey: .star_rating_htl)
        new_hotel_address = try values.decodeIfPresent(String.self, forKey: .new_hotel_address)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
        
    }
    
}

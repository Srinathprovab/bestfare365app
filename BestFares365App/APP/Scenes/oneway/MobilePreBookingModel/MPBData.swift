//
//  MPBData.swift
//  BestFares365App
//
//  Created by FCI on 10/03/23.
//

import Foundation


struct MPBData : Codable {
    
    let active_payment_options : [String]?
    let pax_details : Bool?
    let sms_charge : String?
    let charity_charge : String?
    let checkin_charge : String?
    let extra_services : [String]?
    let booking_source : String?
    let phone_code : [Phone_code]?
    let pre_booking_params : Pre_booking_params?
    let currency_obj : Currency_obj?
    let traveller_details : [Traveller_details]?
    let pre_booking_summery : Pre_booking_summery?
    let convenience_fees : Int?
    let is_price_Changed : Bool?
    let user_country_code : String?
    let cart_id : Int?
    let cart_global_id : Int?
    let search_access_key : String?
    let sr : String?
    let search_url : String?

    enum CodingKeys: String, CodingKey {

        case active_payment_options = "active_payment_options"
        case pax_details = "pax_details"
        case sms_charge = "sms_charge"
        case charity_charge = "charity_charge"
        case checkin_charge = "checkin_charge"
        case extra_services = "extra_services"
        case booking_source = "booking_source"
        case phone_code = "phone_code"
        case pre_booking_params = "pre_booking_params"
        case currency_obj = "currency_obj"
        case traveller_details = "traveller_details"
        case pre_booking_summery = "pre_booking_summery"
        case convenience_fees = "convenience_fees"
        case is_price_Changed = "is_price_Changed"
        case user_country_code = "user_country_code"
        case cart_id = "cart_id"
        case cart_global_id = "cart_global_id"
        case search_access_key = "search_access_key"
        case sr = "sr"
        case search_url = "search_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        active_payment_options = try values.decodeIfPresent([String].self, forKey: .active_payment_options)
        pax_details = try values.decodeIfPresent(Bool.self, forKey: .pax_details)
        sms_charge = try values.decodeIfPresent(String.self, forKey: .sms_charge)
        charity_charge = try values.decodeIfPresent(String.self, forKey: .charity_charge)
        checkin_charge = try values.decodeIfPresent(String.self, forKey: .checkin_charge)
        extra_services = try values.decodeIfPresent([String].self, forKey: .extra_services)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        phone_code = try values.decodeIfPresent([Phone_code].self, forKey: .phone_code)
        pre_booking_params = try values.decodeIfPresent(Pre_booking_params.self, forKey: .pre_booking_params)
        currency_obj = try values.decodeIfPresent(Currency_obj.self, forKey: .currency_obj)
        traveller_details = try values.decodeIfPresent([Traveller_details].self, forKey: .traveller_details)
        pre_booking_summery = try values.decodeIfPresent(Pre_booking_summery.self, forKey: .pre_booking_summery)
        convenience_fees = try values.decodeIfPresent(Int.self, forKey: .convenience_fees)
        is_price_Changed = try values.decodeIfPresent(Bool.self, forKey: .is_price_Changed)
        user_country_code = try values.decodeIfPresent(String.self, forKey: .user_country_code)
        cart_id = try values.decodeIfPresent(Int.self, forKey: .cart_id)
        cart_global_id = try values.decodeIfPresent(Int.self, forKey: .cart_global_id)
        search_access_key = try values.decodeIfPresent(String.self, forKey: .search_access_key)
        sr = try values.decodeIfPresent(String.self, forKey: .sr)
        search_url = try values.decodeIfPresent(String.self, forKey: .search_url)
    }

}

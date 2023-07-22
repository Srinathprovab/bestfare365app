//
//  HMBModel.swift
//  BestFares365App
//
//  Created by FCI on 27/03/23.
//

import Foundation


struct HMBModel : Codable {
    
    
    let active_payment_options : [String]?
    //    let pax_details : Bool?
    //    let active_data : Active_data?
    //    let phone_code : [Phone_code]?
    //    let user_country_code : String?
    //    let booking_source : String?
    let pre_booking_params : HMBPre_booking_params?
    //    let accomodation_type_code : String?
    //    let category_code : String?
    //    let categoryName : String?
    //    let room_paxes_details : [String]?
    //    let total_price : Int?
    //    let convenience_fees_data : Convenience_fees_data?
    //    let convenience_fees : String?
    //    let admin_markup : String?
    //    let agent_markup : String?
    //    let term_policy : [Term_policy]?
    //    let tax_service_sum : String?
    //    let traveller_details : Bool?
    //    let hotel_address_inf : String?
    //    let getrateComment : String?
    //    let base_en_rate : String?
    //    let hotel_total_price : Int?
    //    let comb_status : Int?
    //    let adult_count : String?
    //    let child_count : String?
    //    let passenger_country : String?
    //    let tour_data : String?
    
    enum CodingKeys: String, CodingKey {
        
        case active_payment_options = "active_payment_options"
        //        case pax_details = "pax_details"
        //        case active_data = "active_data"
        //        case phone_code = "phone_code"
        //        case user_country_code = "user_country_code"
        //        case booking_source = "booking_source"
        case pre_booking_params = "pre_booking_params"
        //        case accomodation_type_code = "accomodation_type_code"
        //        case category_code = "category_code"
        //        case categoryName = "categoryName"
        //        case room_paxes_details = "room_paxes_details"
        //      case total_price = "total_price"
        //        case convenience_fees_data = "convenience_fees_data"
        //        case convenience_fees = "convenience_fees"
        //        case admin_markup = "admin_markup"
        //        case agent_markup = "agent_markup"
        //        case term_policy = "term_policy"
        //        case tax_service_sum = "tax_service_sum"
        //        case traveller_details = "traveller_details"
        //        case hotel_address_inf = "hotel_address_inf"
        //        case getrateComment = "getrateComment"
        //        case base_en_rate = "base_en_rate"
        //        case hotel_total_price = "hotel_total_price"
        //        case comb_status = "comb_status"
        //        case adult_count = "adult_count"
        //        case child_count = "child_count"
        //        case passenger_country = "passenger_country"
        //        case tour_data = "tour_data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        active_payment_options = try values.decodeIfPresent([String].self, forKey: .active_payment_options)
        //        pax_details = try values.decodeIfPresent(Bool.self, forKey: .pax_details)
        //        active_data = try values.decodeIfPresent(Active_data.self, forKey: .active_data)
        //        phone_code = try values.decodeIfPresent([Phone_code].self, forKey: .phone_code)
        //        user_country_code = try values.decodeIfPresent(String.self, forKey: .user_country_code)
        //        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        pre_booking_params = try values.decodeIfPresent(HMBPre_booking_params.self, forKey: .pre_booking_params)
        //        accomodation_type_code = try values.decodeIfPresent(String.self, forKey: .accomodation_type_code)
        //        category_code = try values.decodeIfPresent(String.self, forKey: .category_code)
        //        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        //        room_paxes_details = try values.decodeIfPresent([String].self, forKey: .room_paxes_details)
        //     total_price = try values.decodeIfPresent(Int.self, forKey: .total_price)
        //        convenience_fees_data = try values.decodeIfPresent(Convenience_fees_data.self, forKey: .convenience_fees_data)
        //        convenience_fees = try values.decodeIfPresent(String.self, forKey: .convenience_fees)
        //        admin_markup = try values.decodeIfPresent(String.self, forKey: .admin_markup)
        //        agent_markup = try values.decodeIfPresent(String.self, forKey: .agent_markup)
        //        term_policy = try values.decodeIfPresent([Term_policy].self, forKey: .term_policy)
        //        tax_service_sum = try values.decodeIfPresent(String.self, forKey: .tax_service_sum)
        //        traveller_details = try values.decodeIfPresent(Bool.self, forKey: .traveller_details)
        //        hotel_address_inf = try values.decodeIfPresent(String.self, forKey: .hotel_address_inf)
        //        getrateComment = try values.decodeIfPresent(String.self, forKey: .getrateComment)
        //        base_en_rate = try values.decodeIfPresent(String.self, forKey: .base_en_rate)
        //        hotel_total_price = try values.decodeIfPresent(Int.self, forKey: .hotel_total_price)
        //        comb_status = try values.decodeIfPresent(Int.self, forKey: .comb_status)
        //        adult_count = try values.decodeIfPresent(String.self, forKey: .adult_count)
        //        child_count = try values.decodeIfPresent(String.self, forKey: .child_count)
        //        passenger_country = try values.decodeIfPresent(String.self, forKey: .passenger_country)
        //        tour_data = try values.decodeIfPresent(String.self, forKey: .tour_data)
    }
    
}

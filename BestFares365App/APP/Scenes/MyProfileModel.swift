//
//  MyProfileModel.swift
//  BestFares365App
//
//  Created by FCI on 31/01/23.
//

import Foundation



struct MyProfileModel : Codable {
    
    let title : String?
    let first_name : String?
    let last_name : String?
    let user_country_code : String?
    let date_of_birth : String?
    let address : String?
    let phone : String?
    let email : String?
    let profile_image : String?
//    let latest_transaction : [String]?
//    let user_passport_visa_details : [String]?
//    let traveller_details : [String]?
    
    
    enum CodingKeys: String, CodingKey {
        
        case title = "title"
        case first_name = "first_name"
        case last_name = "last_name"
        case user_country_code = "user_country_code"
        case date_of_birth = "date_of_birth"
        case address = "address"
        case phone = "phone"
        case email = "email"
        case profile_image = "profile_image"
//        case latest_transaction = "latest_transaction"
//        case user_passport_visa_details = "user_passport_visa_details"
//        case traveller_details = "traveller_details"
    
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        user_country_code = try values.decodeIfPresent(String.self, forKey: .user_country_code)
        date_of_birth = try values.decodeIfPresent(String.self, forKey: .date_of_birth)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
//        latest_transaction = try values.decodeIfPresent([String].self, forKey: .latest_transaction)
//        user_passport_visa_details = try values.decodeIfPresent([String].self, forKey: .user_passport_visa_details)
//        traveller_details = try values.decodeIfPresent([String].self, forKey: .traveller_details)
       
    }
    
}

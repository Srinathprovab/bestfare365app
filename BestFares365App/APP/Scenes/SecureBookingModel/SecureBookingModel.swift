//
//  SecureBookingModel.swift
//  BestFares365App
//
//  Created by FCI on 13/03/23.
//

import Foundation



struct SecureBookingModel : Codable {
    let status : Bool?
    let url : String?
    let message : String?
    

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case url = "url"
        case message = "message"
       
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        
    }

}

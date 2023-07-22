//
//  LoginModel.swift
//  BestFares365App
//
//  Created by FCI on 07/11/22.
//

import Foundation

struct LoginModel : Codable {
    
    let status : Bool?
    let data : String?
    let user_id : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case user_id = "user_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(String.self, forKey: .data)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
    }

}



struct RegisterModel : Codable {
    let status : Bool?
    let data : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(String.self, forKey: .data)
    }

}




struct ResetPasswordModel : Codable {
    let status : Bool?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}

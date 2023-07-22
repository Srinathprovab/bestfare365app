//
//  CurrencyListModel.swift
//  BestFares365App
//
//  Created by FCI on 16/02/23.
//

import Foundation




import Foundation
struct CurrencyListModel : Codable {
    
    let id : String?
    let status : String?
    let country : String?
    let value : String?
    let currency_symbol : String?
    let date_time : String?
    let country_name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case status = "status"
        case country = "country"
        case value = "value"
        case currency_symbol = "currency_symbol"
        case date_time = "date_time"
        case country_name = "country_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        currency_symbol = try values.decodeIfPresent(String.self, forKey: .currency_symbol)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
    }

}

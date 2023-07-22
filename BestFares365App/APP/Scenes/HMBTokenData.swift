//
//  HMBTokenData.swift
//  BestFares365App
//
//  Created by FCI on 13/06/23.
//

import Foundation

struct HMBTokenData : Codable {
    let hotel_code : Int?
    let hotel_name : String?
    let star_rating : String?
    let destination : String?
    let destination_code : String?
    let zone_code : Int?
    let zone : String?
    let latitude : String?
    let longitude : String?
    let currency : String?
    let checkIn : String?
    let checkOut : String?
    let rooms : [HMBRooms]?
    let imagePath : String?
    let small_image_baseUrl : String?
    let cancellationString : String?
    let total_price : Double?
    let convinence : String?

    enum CodingKeys: String, CodingKey {

        case hotel_code = "hotel_code"
        case hotel_name = "hotel_name"
        case star_rating = "star_rating"
        case destination = "destination"
        case destination_code = "destination_code"
        case zone_code = "zone_code"
        case zone = "zone"
        case latitude = "latitude"
        case longitude = "longitude"
        case currency = "currency"
        case checkIn = "checkIn"
        case checkOut = "checkOut"
        case rooms = "rooms"
        case imagePath = "imagePath"
        case small_image_baseUrl = "small_image_baseUrl"
        case cancellationString = "cancellationString"
        case total_price = "total_price"
        case convinence = "convinence"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hotel_code = try values.decodeIfPresent(Int.self, forKey: .hotel_code)
        hotel_name = try values.decodeIfPresent(String.self, forKey: .hotel_name)
        star_rating = try values.decodeIfPresent(String.self, forKey: .star_rating)
        destination = try values.decodeIfPresent(String.self, forKey: .destination)
        destination_code = try values.decodeIfPresent(String.self, forKey: .destination_code)
        zone_code = try values.decodeIfPresent(Int.self, forKey: .zone_code)
        zone = try values.decodeIfPresent(String.self, forKey: .zone)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        checkIn = try values.decodeIfPresent(String.self, forKey: .checkIn)
        checkOut = try values.decodeIfPresent(String.self, forKey: .checkOut)
        rooms = try values.decodeIfPresent([HMBRooms].self, forKey: .rooms)
        imagePath = try values.decodeIfPresent(String.self, forKey: .imagePath)
        small_image_baseUrl = try values.decodeIfPresent(String.self, forKey: .small_image_baseUrl)
        cancellationString = try values.decodeIfPresent(String.self, forKey: .cancellationString)
        total_price = try values.decodeIfPresent(Double.self, forKey: .total_price)
        convinence = try values.decodeIfPresent(String.self, forKey: .convinence)
    }

}

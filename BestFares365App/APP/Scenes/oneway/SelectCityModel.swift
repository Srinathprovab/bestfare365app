




import Foundation


//struct selectCityModel : Codable {
//    let results : [SelectCityModel]?
//
//    enum CodingKeys: String, CodingKey {
//        case results = "results"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        results = try values.decodeIfPresent([SelectCityModel].self, forKey: .results)
//    }
//
//}




struct SelectCityModel : Codable {
    let origin : String?
    let airport_code : String?
    let airport_name : String?
    let airport_city : String?
    let country : String?
    let priority : String?
    let sub_priority : String?
    let lable : String?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case airport_code = "airport_code"
        case airport_name = "airport_name"
        case airport_city = "airport_city"
        case country = "country"
        case priority = "priority"
        case sub_priority = "sub_priority"
        case lable = "lable"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        airport_code = try values.decodeIfPresent(String.self, forKey: .airport_code)
        airport_name = try values.decodeIfPresent(String.self, forKey: .airport_name)
        airport_city = try values.decodeIfPresent(String.self, forKey: .airport_city)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        priority = try values.decodeIfPresent(String.self, forKey: .priority)
        sub_priority = try values.decodeIfPresent(String.self, forKey: .sub_priority)
        lable = try values.decodeIfPresent(String.self, forKey: .lable)
    }

}



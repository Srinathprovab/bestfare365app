




import Foundation
struct SelectCityModel : Codable {
    
    let label : String?
    let value : String?
    let id : String?
    let category : String?
    let type : String?
    let airportCode : String?
    let airportName : String?
    
    
    enum CodingKeys: String, CodingKey {
        
        case label = "label"
        case value = "value"
        case id = "id"
        case category = "category"
        case type = "type"
        case airportCode = "airportCode"
        case airportName = "airportName"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        airportCode = try values.decodeIfPresent(String.self, forKey: .airportCode)
        airportName = try values.decodeIfPresent(String.self, forKey: .airportName)
    }
    
}

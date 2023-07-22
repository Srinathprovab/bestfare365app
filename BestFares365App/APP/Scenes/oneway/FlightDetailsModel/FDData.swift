

import Foundation
struct FDData : Codable {
    let flight_details : [[FDFlight_details]]?
  //  let fare_rules : [FareRulehtml]?
    let fare_details : FDFare_details?
    let token : String?
    let token_key : String?
    let session_id : String?

    enum CodingKeys: String, CodingKey {

        case flight_details = "flight_details"
  //      case fare_rules = "fare_rules"
        case fare_details = "fare_details"
        case token = "token"
        case token_key = "token_key"
        case session_id = "session_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        flight_details = try values.decodeIfPresent([[FDFlight_details]].self, forKey: .flight_details)
  //      fare_rules = try values.decodeIfPresent([FareRulehtml].self, forKey: .fare_rules)
        fare_details = try values.decodeIfPresent(FDFare_details.self, forKey: .fare_details)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        token_key = try values.decodeIfPresent(String.self, forKey: .token_key)
        session_id = try values.decodeIfPresent(String.self, forKey: .session_id)
    }

}


struct FareRulehtml : Codable {
    let rule_content : String?
    let rule_type : String?
    let rule_heading : String?
    let rule_category : String?

    enum CodingKeys: String, CodingKey {

        case rule_content = "rule_content"
        case rule_type = "rule_type"
        case rule_heading = "rule_heading"
        case rule_category = "rule_category"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rule_content = try values.decodeIfPresent(String.self, forKey: .rule_content)
        rule_type = try values.decodeIfPresent(String.self, forKey: .rule_type)
        rule_heading = try values.decodeIfPresent(String.self, forKey: .rule_heading)
        rule_category = try values.decodeIfPresent(String.self, forKey: .rule_category)
    }

}

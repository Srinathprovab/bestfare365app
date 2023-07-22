
import Foundation
struct PassengerFareBreakdown : Codable {
    let aDT : ADT?
    let cH : CH?
    let iNF : INF?

    enum CodingKeys: String, CodingKey {

        case aDT = "ADT"
        case cH = "CH"
        case iNF = "INF"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        aDT = try values.decodeIfPresent(ADT.self, forKey: .aDT)
        cH = try values.decodeIfPresent(CH.self, forKey: .cH)
        iNF = try values.decodeIfPresent(INF.self, forKey: .iNF)
    }

}

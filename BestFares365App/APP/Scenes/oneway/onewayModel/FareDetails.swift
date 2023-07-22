

import Foundation
struct FareDetails : Codable {
    let b2c_PriceDetails : B2c_PriceDetails?
    let api_PriceDetails : Api_PriceDetails?

    enum CodingKeys: String, CodingKey {

        case b2c_PriceDetails = "b2c_PriceDetails"
        case api_PriceDetails = "api_PriceDetails"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        b2c_PriceDetails = try values.decodeIfPresent(B2c_PriceDetails.self, forKey: .b2c_PriceDetails)
        api_PriceDetails = try values.decodeIfPresent(Api_PriceDetails.self, forKey: .api_PriceDetails)
    }

}

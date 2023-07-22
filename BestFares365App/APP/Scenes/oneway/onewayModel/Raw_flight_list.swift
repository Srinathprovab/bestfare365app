

import Foundation
struct Raw_flight_list : Codable {
    let flights : [[Flights]]?

    enum CodingKeys: String, CodingKey {

        case flights = "Flights"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        flights = try values.decodeIfPresent([[Flights]].self, forKey: .flights)
    }

}

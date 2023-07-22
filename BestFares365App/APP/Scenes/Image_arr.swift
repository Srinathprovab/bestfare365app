
import Foundation
struct Image_arr : Codable {
	let imageCode : String?
	let imagePath : String?
	let roomCode : String?
	let roomType : String?

	enum CodingKeys: String, CodingKey {

		case imageCode = "imageCode"
		case imagePath = "imagePath"
		case roomCode = "roomCode"
		case roomType = "roomType"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		imageCode = try values.decodeIfPresent(String.self, forKey: .imageCode)
		imagePath = try values.decodeIfPresent(String.self, forKey: .imagePath)
		roomCode = try values.decodeIfPresent(String.self, forKey: .roomCode)
		roomType = try values.decodeIfPresent(String.self, forKey: .roomType)
	}

}

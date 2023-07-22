

import Foundation
struct Rates : Codable {
	let rateKey : String?
	let rateClass : String?
	let rateType : String?
	let allotment : Int?
	let rateCommentsId : String?
	let rateComments : String?
	let paymentType : String?
	let boardCode : String?
	let boardName : String?
	let net : Double?
	let rooms : Int?
	let adults : Int?
	let children : Int?
	let childrenAges : String?

	enum CodingKeys: String, CodingKey {

		case rateKey = "rateKey"
		case rateClass = "rateClass"
		case rateType = "rateType"
		case allotment = "allotment"
		case rateCommentsId = "rateCommentsId"
		case rateComments = "rateComments"
		case paymentType = "paymentType"
		case boardCode = "boardCode"
		case boardName = "boardName"
		case net = "net"
		case rooms = "rooms"
		case adults = "adults"
		case children = "children"
		case childrenAges = "childrenAges"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		rateKey = try values.decodeIfPresent(String.self, forKey: .rateKey)
		rateClass = try values.decodeIfPresent(String.self, forKey: .rateClass)
		rateType = try values.decodeIfPresent(String.self, forKey: .rateType)
		allotment = try values.decodeIfPresent(Int.self, forKey: .allotment)
		rateCommentsId = try values.decodeIfPresent(String.self, forKey: .rateCommentsId)
		rateComments = try values.decodeIfPresent(String.self, forKey: .rateComments)
		paymentType = try values.decodeIfPresent(String.self, forKey: .paymentType)
		boardCode = try values.decodeIfPresent(String.self, forKey: .boardCode)
		boardName = try values.decodeIfPresent(String.self, forKey: .boardName)
		net = try values.decodeIfPresent(Double.self, forKey: .net)
		rooms = try values.decodeIfPresent(Int.self, forKey: .rooms)
		adults = try values.decodeIfPresent(Int.self, forKey: .adults)
		children = try values.decodeIfPresent(Int.self, forKey: .children)
		childrenAges = try values.decodeIfPresent(String.self, forKey: .childrenAges)
	}

}

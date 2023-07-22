
import Foundation
struct Rooms : Codable {
	let rateKey : String?
	let rateClass : String?
	let rateType : String?
	let net : Double?
	let allotment : Int?
	let paymentType : String?
	let packaging : Bool?
	let boardCode : String?
	let boardName : String?
	let cancellationPolicies : [CancellationPolicies]?
	let taxes : Taxes?
	let rooms : Int?
	let adults : Int?
	let children : Int?
	let childrenAges : String?
	let code : String?
	let name : String?
	let admin_markup : Int?
	let agent_markup : Int?

	enum CodingKeys: String, CodingKey {

		case rateKey = "rateKey"
		case rateClass = "rateClass"
		case rateType = "rateType"
		case net = "net"
		case allotment = "allotment"
		case paymentType = "paymentType"
		case packaging = "packaging"
		case boardCode = "boardCode"
		case boardName = "boardName"
		case cancellationPolicies = "cancellationPolicies"
		case taxes = "taxes"
		case rooms = "rooms"
		case adults = "adults"
		case children = "children"
		case childrenAges = "childrenAges"
		case code = "code"
		case name = "name"
		case admin_markup = "admin_markup"
		case agent_markup = "agent_markup"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		rateKey = try values.decodeIfPresent(String.self, forKey: .rateKey)
		rateClass = try values.decodeIfPresent(String.self, forKey: .rateClass)
		rateType = try values.decodeIfPresent(String.self, forKey: .rateType)
		net = try values.decodeIfPresent(Double.self, forKey: .net)
		allotment = try values.decodeIfPresent(Int.self, forKey: .allotment)
		paymentType = try values.decodeIfPresent(String.self, forKey: .paymentType)
		packaging = try values.decodeIfPresent(Bool.self, forKey: .packaging)
		boardCode = try values.decodeIfPresent(String.self, forKey: .boardCode)
		boardName = try values.decodeIfPresent(String.self, forKey: .boardName)
		cancellationPolicies = try values.decodeIfPresent([CancellationPolicies].self, forKey: .cancellationPolicies)
		taxes = try values.decodeIfPresent(Taxes.self, forKey: .taxes)
		rooms = try values.decodeIfPresent(Int.self, forKey: .rooms)
		adults = try values.decodeIfPresent(Int.self, forKey: .adults)
		children = try values.decodeIfPresent(Int.self, forKey: .children)
		childrenAges = try values.decodeIfPresent(String.self, forKey: .childrenAges)
		code = try values.decodeIfPresent(String.self, forKey: .code)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		admin_markup = try values.decodeIfPresent(Int.self, forKey: .admin_markup)
		agent_markup = try values.decodeIfPresent(Int.self, forKey: .agent_markup)
	}

}


import Foundation
struct Cancellation_details : Codable {
	let origin : String?
	let passenger_fk : String?
	let requestId : String?
	let changeRequestStatus : String?
	let statusDescription : String?
	let aPI_RefundedAmount : String?
	let aPI_CancellationCharge : String?
	let aPI_ServiceTaxOnRefundAmount : String?
	let aPI_SwachhBharatCess : String?
	let aPI_refund_status : String?
	let cancellation_requested_on : String?
	let cancellation_processed_on : String?
	let refund_amount : String?
	let cancellation_charge : String?
	let service_tax_on_refund_amount : String?
	let swachh_bharat_cess : String?
	let refund_status : String?
	let refund_payment_mode : String?
	let refund_comments : String?
	let refund_date : String?
	let currency : String?
	let currency_conversion_rate : String?
	let created_by_id : String?
	let created_datetime : String?
	let pax_cancel_details : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case passenger_fk = "passenger_fk"
		case requestId = "RequestId"
		case changeRequestStatus = "ChangeRequestStatus"
		case statusDescription = "statusDescription"
		case aPI_RefundedAmount = "API_RefundedAmount"
		case aPI_CancellationCharge = "API_CancellationCharge"
		case aPI_ServiceTaxOnRefundAmount = "API_ServiceTaxOnRefundAmount"
		case aPI_SwachhBharatCess = "API_SwachhBharatCess"
		case aPI_refund_status = "API_refund_status"
		case cancellation_requested_on = "cancellation_requested_on"
		case cancellation_processed_on = "cancellation_processed_on"
		case refund_amount = "refund_amount"
		case cancellation_charge = "cancellation_charge"
		case service_tax_on_refund_amount = "service_tax_on_refund_amount"
		case swachh_bharat_cess = "swachh_bharat_cess"
		case refund_status = "refund_status"
		case refund_payment_mode = "refund_payment_mode"
		case refund_comments = "refund_comments"
		case refund_date = "refund_date"
		case currency = "currency"
		case currency_conversion_rate = "currency_conversion_rate"
		case created_by_id = "created_by_id"
		case created_datetime = "created_datetime"
		case pax_cancel_details = "pax_cancel_details"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		passenger_fk = try values.decodeIfPresent(String.self, forKey: .passenger_fk)
		requestId = try values.decodeIfPresent(String.self, forKey: .requestId)
		changeRequestStatus = try values.decodeIfPresent(String.self, forKey: .changeRequestStatus)
		statusDescription = try values.decodeIfPresent(String.self, forKey: .statusDescription)
		aPI_RefundedAmount = try values.decodeIfPresent(String.self, forKey: .aPI_RefundedAmount)
		aPI_CancellationCharge = try values.decodeIfPresent(String.self, forKey: .aPI_CancellationCharge)
		aPI_ServiceTaxOnRefundAmount = try values.decodeIfPresent(String.self, forKey: .aPI_ServiceTaxOnRefundAmount)
		aPI_SwachhBharatCess = try values.decodeIfPresent(String.self, forKey: .aPI_SwachhBharatCess)
		aPI_refund_status = try values.decodeIfPresent(String.self, forKey: .aPI_refund_status)
		cancellation_requested_on = try values.decodeIfPresent(String.self, forKey: .cancellation_requested_on)
		cancellation_processed_on = try values.decodeIfPresent(String.self, forKey: .cancellation_processed_on)
		refund_amount = try values.decodeIfPresent(String.self, forKey: .refund_amount)
		cancellation_charge = try values.decodeIfPresent(String.self, forKey: .cancellation_charge)
		service_tax_on_refund_amount = try values.decodeIfPresent(String.self, forKey: .service_tax_on_refund_amount)
		swachh_bharat_cess = try values.decodeIfPresent(String.self, forKey: .swachh_bharat_cess)
		refund_status = try values.decodeIfPresent(String.self, forKey: .refund_status)
		refund_payment_mode = try values.decodeIfPresent(String.self, forKey: .refund_payment_mode)
		refund_comments = try values.decodeIfPresent(String.self, forKey: .refund_comments)
		refund_date = try values.decodeIfPresent(String.self, forKey: .refund_date)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		currency_conversion_rate = try values.decodeIfPresent(String.self, forKey: .currency_conversion_rate)
		created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
		created_datetime = try values.decodeIfPresent(String.self, forKey: .created_datetime)
		pax_cancel_details = try values.decodeIfPresent(String.self, forKey: .pax_cancel_details)
	}

}

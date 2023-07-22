

import Foundation
struct Raw_hotel_list : Codable {
    let hotel_code : Int?
    let class_rate : String?
    let name : String?
    let star_rating : Int?
    let category_code : String?
    let star_rating_text : String?
    let latitude : String?
    let longitude : String?
    let free_cancellation_date : String?
    let price : Double?
    let markup_value : String?
    let currency : String?
    let address : String?
    let location : String?
    let facility_cstr : String?
    let facility : [Facility_search]?
    let boards : [Boards]?
    let facility_search : [Facility_search]?
    let img : String?
    let postal : String?
    let accomodation_type : String?
    let accomodation_cstr : String?
    let category_display : String?
    let category_description : String?
    let booking_source : String?
    let chain : String?
    let hotel_chain : String?
    let promotions : String?
    let offers : String?
    let rmns_name : String?
    let rate_class : String?
    let rmns_count : Int?
    let offer_name : String?

    enum CodingKeys: String, CodingKey {

        case hotel_code = "hotel_code"
        case class_rate = "class_rate"
        case name = "name"
        case star_rating = "star_rating"
        case category_code = "category_code"
        case star_rating_text = "star_rating_text"
        case latitude = "latitude"
        case longitude = "longitude"
        case free_cancellation_date = "free_cancellation_date"
        case price = "price"
        case markup_value = "markup_value"
        case currency = "currency"
        case address = "address"
        case location = "location"
        case facility_cstr = "facility_cstr"
        case facility = "facility"
        case boards = "boards"
        case facility_search = "facility_search"
        case img = "img"
        case postal = "postal"
        case accomodation_type = "accomodation_type"
        case accomodation_cstr = "accomodation_cstr"
        case category_display = "category_display"
        case category_description = "category_description"
        case booking_source = "booking_source"
        case chain = "chain"
        case hotel_chain = "hotel_chain"
        case promotions = "promotions"
        case offers = "offers"
        case rmns_name = "rmns_name"
        case rate_class = "rate_class"
        case rmns_count = "rmns_count"
        case offer_name = "offer_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hotel_code = try values.decodeIfPresent(Int.self, forKey: .hotel_code)
        class_rate = try values.decodeIfPresent(String.self, forKey: .class_rate)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        star_rating = try values.decodeIfPresent(Int.self, forKey: .star_rating)
        category_code = try values.decodeIfPresent(String.self, forKey: .category_code)
        star_rating_text = try values.decodeIfPresent(String.self, forKey: .star_rating_text)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        free_cancellation_date = try values.decodeIfPresent(String.self, forKey: .free_cancellation_date)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        markup_value = try values.decodeIfPresent(String.self, forKey: .markup_value)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        facility_cstr = try values.decodeIfPresent(String.self, forKey: .facility_cstr)
        facility = try values.decodeIfPresent([Facility_search].self, forKey: .facility)
        boards = try values.decodeIfPresent([Boards].self, forKey: .boards)
        facility_search = try values.decodeIfPresent([Facility_search].self, forKey: .facility_search)
        img = try values.decodeIfPresent(String.self, forKey: .img)
        postal = try values.decodeIfPresent(String.self, forKey: .postal)
        accomodation_type = try values.decodeIfPresent(String.self, forKey: .accomodation_type)
        accomodation_cstr = try values.decodeIfPresent(String.self, forKey: .accomodation_cstr)
        category_display = try values.decodeIfPresent(String.self, forKey: .category_display)
        category_description = try values.decodeIfPresent(String.self, forKey: .category_description)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        chain = try values.decodeIfPresent(String.self, forKey: .chain)
        hotel_chain = try values.decodeIfPresent(String.self, forKey: .hotel_chain)
        promotions = try values.decodeIfPresent(String.self, forKey: .promotions)
        offers = try values.decodeIfPresent(String.self, forKey: .offers)
        rmns_name = try values.decodeIfPresent(String.self, forKey: .rmns_name)
        rate_class = try values.decodeIfPresent(String.self, forKey: .rate_class)
        rmns_count = try values.decodeIfPresent(Int.self, forKey: .rmns_count)
        offer_name = try values.decodeIfPresent(String.self, forKey: .offer_name)
    }

}

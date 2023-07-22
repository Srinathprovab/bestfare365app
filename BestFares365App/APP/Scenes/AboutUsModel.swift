//
//  AboutUsModel.swift
//  BestFares365App
//
//  Created by FCI on 10/03/23.
//

import Foundation


import Foundation
struct AboutUsModel : Codable {
    let status : Int?
    let data : [AboutUsData]?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent([AboutUsData].self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}




struct AboutUsData : Codable {
    let page_title : String?
    let page_description : String?
    let page_seo_title : String?
    let page_seo_keyword : String?
    let page_seo_description : String?

    enum CodingKeys: String, CodingKey {

        case page_title = "page_title"
        case page_description = "page_description"
        case page_seo_title = "page_seo_title"
        case page_seo_keyword = "page_seo_keyword"
        case page_seo_description = "page_seo_description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page_title = try values.decodeIfPresent(String.self, forKey: .page_title)
        page_description = try values.decodeIfPresent(String.self, forKey: .page_description)
        page_seo_title = try values.decodeIfPresent(String.self, forKey: .page_seo_title)
        page_seo_keyword = try values.decodeIfPresent(String.self, forKey: .page_seo_keyword)
        page_seo_description = try values.decodeIfPresent(String.self, forKey: .page_seo_description)
    }

}

//
//  AdList.swift
//  PaperClip
//
//  Created by Tiago Antunes on 16/02/2025.
//

import Foundation

struct AdList: Codable {
    /*private enum CodingKeys: String, CodingKey {
        case ads = "results"

        //case page
        //case totalPages = "total_pages"
        //case totalResults = "total_results"
    }*/

    var ads: [AdItem]
    //let page: Int
    //let totalPages: Int
    //let totalResults: Int

    init(ads: [AdItem]) {
        self.ads = ads
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        ads = try container.decode([AdItem].self)
    }
}

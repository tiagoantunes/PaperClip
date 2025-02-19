//
//  AdList.swift
//  PaperClip
//
//  Created by Tiago Antunes on 16/02/2025.
//

import Foundation

struct AdList: Codable {
    var ads: [AdItem]

    init(ads: [AdItem]) {
        self.ads = ads
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        ads = try container.decode([AdItem].self)
    }
}

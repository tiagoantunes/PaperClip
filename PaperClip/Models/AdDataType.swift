//
//  AdDataType.swift
//  PaperClip
//
//  Created by Tiago Antunes on 16/02/2025.
//

enum AdDataType {
    case ads
    case categories

    var path: String {
        switch self {
        case .ads:
            "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"
        case .categories:
            "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json"
        }
    }
}

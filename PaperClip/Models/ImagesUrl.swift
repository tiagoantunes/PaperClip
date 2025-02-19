//
//  ImagesUrl.swift
//  PaperClip
//
//  Created by Tiago Antunes on 16/02/2025.
//

struct ImagesUrl: Codable {
    private enum CodingKeys: String, CodingKey {
        case small
        case thumb
    }

    let small: String?
    let thumb: String?

    init(
        small: String,
        thumb: String
    ) {
        self.small = small
        self.thumb = thumb
    }
}

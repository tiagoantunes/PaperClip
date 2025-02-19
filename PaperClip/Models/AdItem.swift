//
//  AdItem.swift
//  PaperClip
//
//  Created by Tiago Antunes on 16/02/2025.
//

import Foundation

struct AdItem: Codable, Identifiable {
    private enum CodingKeys: String, CodingKey {
        case id
        case categoryId = "category_id"
        case title
        case description
        case price
        case imagesUrl = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
    }

    let id: Int
    let categoryId: Int
    let title: String
    let description: String
    let price: Float
    let imagesUrl: ImagesUrl
    let creationDate: String
    let isUrgent: Bool
    let siret: String?

    init(
        id: Int,
        categoryId: Int,
        title: String,
        description: String,
        price: Float,
        imagesUrl: ImagesUrl,
        creationDate: String,
        isUrgent: Bool,
        siret: String? = nil
    ) {
        self.id = id
        self.categoryId = categoryId
        self.title = title
        self.description = description
        self.price = price
        self.imagesUrl = imagesUrl
        self.creationDate = creationDate
        self.isUrgent = isUrgent
        self.siret = siret
    }
}

extension AdItem: Equatable, Hashable {
    static func == (lhs: AdItem, rhs: AdItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

extension AdItem {
    var thumbImageUrl: URL? {
        guard let url = imagesUrl.thumb else { return nil }
        return URL(string: url)
    }

    var smallImageUrl: URL? {
        guard let url = imagesUrl.small else { return nil }
        return URL(string: url)
    }
}

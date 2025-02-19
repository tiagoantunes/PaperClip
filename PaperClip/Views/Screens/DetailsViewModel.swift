//
//  DetailsViewModel.swift
//  PaperClip
//
//  Created by Tiago Antunes on 16/02/2025.
//

import Combine
import Foundation

protocol DetailsViewModelProtocol: ObservableObject {
    var title: String { get }
    var description: String { get }
    var price: String { get }
    var creationDate: String? { get }
    var thumbImageUrl: URL? { get }
    var smallImageUrl: URL? { get }
    var saleType: String { get }
    var siretCode: String? { get }
    var categoryName: String? { get }
}

final class DetailsViewModel: DetailsViewModelProtocol {
    private var ad: AdItem
    private let category: AdCategory?

    init(
        ad: AdItem,
        category: AdCategory?
    ) {
        self.ad = ad
        self.category = category
    }
}

extension DetailsViewModel {

    var title: String {
        ad.title
    }
    
    var description: String {
        ad.description
    }

    var price: String {
        "\(ad.price)€"
    }

    var creationDate: String? {
        let dateFormatter = ISO8601DateFormatter()

        dateFormatter.formatOptions = [
            .withFullDate
        ]

        if let date = dateFormatter.date(from: ad.creationDate) {
            return dateFormatter.string(from: date)
        }
        return nil
    }

    var thumbImageUrl: URL? {
        guard let url = ad.imagesUrl.thumb else { return nil }
        return URL(string: url)
    }

    var smallImageUrl: URL? {
        guard let url = ad.imagesUrl.small else { return nil }
        return URL(string: url)
    }

    var categoryName: String? {
        category?.name
    }

    var saleType: String {
        ad.isUrgent ? "Urgent Sale ⚡" : "Regular Sale 🛍️"
    }

    var siretCode: String? {
        ad.siret
    }
}

//
//  ListViewModel.swift
//  PaperClip
//
//  Created by Tiago Antunes on 17/02/2025.
//

import SwiftUI

final class ListViewModel {
    @Binding var ads: [AdItem]
    private let didSelectAd: ((AdItem) -> Void)?

    init(ads: Binding<[AdItem]>, didSelectAd: ((AdItem) -> Void)? = nil) {
        _ads = ads
        self.didSelectAd = didSelectAd
    }

    func cellTitle(for ad: AdItem) -> String {
        ad.title
    }

    func cellImageUrl(for ad: AdItem) -> URL? {
        ad.thumbImageUrl
    }

    func didSelectAd(for ad: AdItem) {
        didSelectAd?(ad)
    }
}

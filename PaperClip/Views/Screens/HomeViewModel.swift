//
//  HomeViewModel.swift
//  PaperClip
//
//  Created by Tiago Antunes on 16/02/2025.
//

import Combine
import Foundation

protocol HomeViewModelProtocol: ObservableObject {
    var showAlert: Bool { get set }
    var isDataLoading: Bool { get }
    var navigationBarTitle: String { get }
    var ads: [AdItem] { get }

    var isSearchActive: Bool { get }
    var searchText: String { get set }
    var searchAds: [AdItem] { get set }

    var dataService: DataServiceProtocol { get }

    func fetchAdsData() async
    func categoryFor(id: Int) -> AdCategory?
    func onTryAgain()
}

final class HomeViewModel: HomeViewModelProtocol {
    private(set) var dataService: DataServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private var allAdsCount: Int = 0

    @Published private(set) var isDataLoading: Bool = true
    @Published var showAlert: Bool = false
    @Published private(set) var ads: [AdItem] = []
    @Published private var adCategories: [AdCategory] = []

    @Published var searchText = ""
    @Published private(set) var isSearchActive = false
    @Published var searchAds: [AdItem] = []

    var navigationBarTitle: String {
        var title = Strings.navigationBarTitle
        if allAdsCount > 0 {
            title += String(format: " (%i/%i)", ads.count, allAdsCount)
        }
        return title
    }

    init(dataService: DataServiceProtocol) {
        self.dataService = dataService

        setupSearch()
    }

    private func setupSearch() {
        $searchText
            .sink { text in
                self.isSearchActive = !text.isEmpty
                self.searchAd(withText: text)
            }
            .store(in: &cancellables)
    }

    func fetchAdsData() async {
        do {
            let adsData = try await dataService.getAdList()
            Logger.log(info: "Downloaded \(adsData.ads.count) Ads")

            let categoriesData = try await dataService.getAdCategories()
            Logger.log(info: "Downloaded \(categoriesData.count) Categories")


            await MainActor.run {
                ads = adsData.ads
                allAdsCount = adsData.ads.count
                adCategories = categoriesData
                isDataLoading = false
            }
        } catch {
            if let error = error as? NetworkError {
                Logger.log(error: error.errorDescription)
                await MainActor.run { showAlert = true }
            }
        }
    }

    func categoryFor(id: Int) -> AdCategory? {
        return adCategories.first(where: { $0.id == id })
    }

    private func searchAd(withText text: String) {
        guard !text.isEmpty else {
            searchAds = []
            return
        }

        let filteredAds = ads.filter { $0.title.contains(text) }
        Logger.log(info: "Searched \(filteredAds.count) ads")
        searchAds = filteredAds
    }

    func onTryAgain() {
        Task {
            await fetchAdsData()
        }
    }
}

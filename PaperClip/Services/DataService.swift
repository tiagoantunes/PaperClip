//
//  DataService.swift
//  PaperClip
//
//  Created by Tiago Antunes on 16/02/2025.
//

import Foundation

protocol DataServiceProtocol {
    func getAdList() async throws -> AdList
    func getAdCategories() async throws -> [AdCategory]
}

final class DataService: DataServiceProtocol {

    private let remoteDataService: RemoteDataServiceProtocol

    init(remoteDataService: RemoteDataServiceProtocol) {
        self.remoteDataService = remoteDataService
    }

    func getAdList() async throws -> AdList {
        let adsData = try await remoteDataService.getAdsData()

        return adsData
    }

    func getAdCategories() async throws -> [AdCategory] {
        return try await remoteDataService.getAdCategories()
    }
}

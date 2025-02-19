//
//  DataServiceTests.swift
//  PaperClip
//
//  Created by Tiago Antunes on 17/02/2025.
//

import XCTest
@testable import PaperClip

class RemoteDataServiceMock: RemoteDataServiceProtocol {
    var morePagesAvailable = false
    var adsDataToReturn: AdList?
    var adCategoriesToReturn: [AdCategory]?
    var errorToThrow: Error?

    func getAdsData() async throws -> AdList {
        if let error = errorToThrow {
            throw error
        }
        return adsDataToReturn ?? AdList(ads: [])
    }

    func getAdCategories() async throws -> [AdCategory] {
        if let error = errorToThrow {
            throw error
        }
        return adCategoriesToReturn ?? []
    }
}

class DataServiceTests: XCTestCase {
    var dataService: DataService!
    var remoteDataServiceMock: RemoteDataServiceMock!

    let ad1 = AdItem(
        id: 1,
        categoryId: 1,
        title: "Ad 1",
        description: "Ad 1 description",
        price: 1.0,
        imagesUrl: ImagesUrl(
            small: "",
            thumb: ""
        ),
        creationDate: "",
        isUrgent: false
    )

    let ad2 = AdItem(
        id: 2,
        categoryId: 2,
        title: "Ad 2",
        description: "Ad 2 description",
        price: 2.0,
        imagesUrl: ImagesUrl(
            small: "",
            thumb: ""
        ),
        creationDate: "",
        isUrgent: false
    )

    override func setUpWithError() throws {
        remoteDataServiceMock = RemoteDataServiceMock()
        dataService = DataService(remoteDataService: remoteDataServiceMock)
    }

    override func tearDownWithError() throws {
        dataService = nil
        remoteDataServiceMock = nil
    }
}

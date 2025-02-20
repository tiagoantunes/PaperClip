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
        id: 1077103477,
        categoryId: 2,
        title: "Ensemble fille 1 mois NEUF",
        description: "Vends Robe avec t-shirt neuf Presti Presto en 1 mois.",
        price: 5.00,
        imagesUrl: ImagesUrl(
            small: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/5ae4741dabd3a236cbfb8b6a5746acba6823e41e.jpg",
            thumb: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/5ae4741dabd3a236cbfb8b6a5746acba6823e41e.jpg"
        ),
        creationDate: "2019-11-05T15:56:52+0000",
        isUrgent: true
    )

    let ad2 = AdItem(
        id: 1671026575,
        categoryId: 8,
        title: "Sony Ericsson Xperia Arc S + coque (occasion)",
        description: "Je vends ce Sony Ericsson Xperia Arc S, TOUT fonctionne PARFAITEMENT.  Le téléphone présente quelques traces d'usures (rayures). Un téléphone comme celui-ci vaut actuellement 80 Euro(s) sur internet, je vous le vends donc pour 50 Euro(s) avec la coque en cadeau !  Modèle : LT18i",
        price: 50.00,
        imagesUrl: ImagesUrl(
            small: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/e0a5bddfc205b940d8679680c3a0e08a6c1cb919.jpg",
            thumb: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/e0a5bddfc205b940d8679680c3a0e08a6c1cb919.jpg"
        ),
        creationDate: "2019-11-05T15:56:50+0000",
        isUrgent: false
    )

    let category1 = AdCategory(
        id: 8,
        name: "Multimédia"
    )

    let category2 = AdCategory(
        id: 9,
        name: "Service"
    )

    func testGetAdList() async throws {
        let ads = [ad1, ad2]
        let adsData = AdList(ads: ads)
        remoteDataServiceMock.adsDataToReturn = adsData

        let result = try await dataService.getAdList()

        XCTAssertEqual(result.ads.count, 2)
        
        XCTAssertEqual(result.ads[0].title, "Ensemble fille 1 mois NEUF")
        XCTAssertEqual(result.ads[1].title, "Sony Ericsson Xperia Arc S + coque (occasion)")
        XCTAssertTrue(result.ads[0].isUrgent)
        XCTAssertFalse(result.ads[1].isUrgent)
    }

    func testGetAdCategories() async throws {
        let categories = [category1, category2]
        remoteDataServiceMock.adCategoriesToReturn = categories

        let result = try await dataService.getAdCategories()

        XCTAssertEqual(result.count, 2)

        XCTAssertEqual(result[0].name, "Multimédia")
        XCTAssertEqual(result[1].name, "Service")
        XCTAssertEqual(result[0].id, 8)
        XCTAssertEqual(result[1].id, 9)
    }


    override func setUpWithError() throws {
        remoteDataServiceMock = RemoteDataServiceMock()
        dataService = DataService(remoteDataService: remoteDataServiceMock)
    }

    override func tearDownWithError() throws {
        dataService = nil
        remoteDataServiceMock = nil
    }
}

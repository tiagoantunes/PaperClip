//
//  RemoteDataServiceTests.swift
//  PaperClip
//
//  Created by Tiago Antunes on 19/02/2025.
//

import XCTest
@testable import PaperClip

class URLSessionMock: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }

        guard let data = data, let response = response else {
            throw NetworkError.invalidResponse
        }

        return (data, response)
    }
}

class RemoteDataServiceTests: XCTestCase {
    var remoteDataService: RemoteDataService!
    var urlSessionMock: URLSessionMock!

    override func setUpWithError() throws {
        urlSessionMock = URLSessionMock()
        remoteDataService = RemoteDataService(session: urlSessionMock)
    }

    override func tearDownWithError() throws {
        remoteDataService = nil
        urlSessionMock = nil
    }

    func testGetAdsData_Success() async throws {
        let jsonString = """
           [
              {
                 "id":1461267313,
                 "category_id":4,
                 "title":"Statue homme noir assis en plâtre polychrome",
                 "description":"Magnifique Statuette homme noir assis fumant le cigare en terre cuite et plâtre polychrome réalisée à la main.  Poids  1,900 kg en très bon état, aucun éclat  !  Hauteur 18 cm  Largeur : 16 cm Profondeur : 18cm  Création Jacky SAMSON  OPTIMUM  PARIS  Possibilité de remise sur place en gare de Fontainebleau ou Paris gare de Lyon, en espèces (heure et jour du rendez-vous au choix). Envoi possible ! Si cet article est toujours visible sur le site c'est qu'il est encore disponible",
                 "price":140.00,
                 "images_url":{
                    "small":"https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg",
                    "thumb":"https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg"
                 },
                 "creation_date":"2019-11-05T15:56:59+0000",
                 "is_urgent":false
              }
            ]
        """
        let jsonData = jsonString.data(using: .utf8)!

        urlSessionMock.data = jsonData
        urlSessionMock.response = HTTPURLResponse(
            url: URL(string: "https://sample.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let adsData = try await remoteDataService.getAdsData()

        XCTAssertEqual(adsData.ads.count, 1)
    }

    func testGetAdsData_Failure_InvalidResponse() async throws {
        urlSessionMock.data = nil
        urlSessionMock.response = HTTPURLResponse(
            url: URL(string: "https://sample.com")!,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )

        do {
            _ = try await remoteDataService.getAdsData()
            XCTFail("Expected NetworkingError.invalidResponse")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.invalidResponse)
        }
    }

    func testGetAdsData_Failure_InvalidJSON() async throws {
        let invalidJSONString = """
        {
            "error": true
        }
        """
        let jsonData = invalidJSONString.data(using: .utf8)!

        urlSessionMock.data = jsonData
        urlSessionMock.response = HTTPURLResponse(
            url: URL(string: "https://sample.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        do {
            _ = try await remoteDataService.getAdsData()
            XCTFail("Expected NetworkingError.parseJSON")
        } catch let error as NetworkError {
            switch error {
            case .parseJSON:
                XCTAssertTrue(true, "Parse JSON error received")
            default:
                XCTFail("Expected Parse JSON error, but received: \(error)")
            }
        }
    }

    func testGetAdsCategories_Success() async throws {
        let jsonString = """
            [
              {
                "id": 1,
                "name": "Véhicule"
              }
            ]
        """
        let jsonData = jsonString.data(using: .utf8)!

        urlSessionMock.data = jsonData
        urlSessionMock.response = HTTPURLResponse(
            url: URL(string: "https://sample.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let adCategories = try await remoteDataService.getAdCategories()

        XCTAssertEqual(adCategories.count, 1)
    }

    func testGetAdsCategories_Failure_InvalidResponse() async throws {
        urlSessionMock.data = nil
        urlSessionMock.response = HTTPURLResponse(
            url: URL(string: "https://sample.com")!,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )

        do {
            _ = try await remoteDataService.getAdCategories()
            XCTFail("Expected NetworkingError.invalidResponse")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.invalidResponse)
        }
    }

    func testGetAdsCategories_Failure_InvalidJSON() async throws {
        let invalidJSONString = """
        {
            "error": true
        }
        """
        let jsonData = invalidJSONString.data(using: .utf8)!

        urlSessionMock.data = jsonData
        urlSessionMock.response = HTTPURLResponse(
            url: URL(string: "https://sample.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        do {
            _ = try await remoteDataService.getAdCategories()
            XCTFail("Expected NetworkingError.parseJSON")
        } catch let error as NetworkError {
            switch error {
            case .parseJSON:
                XCTAssertTrue(true, "Parse JSON error received")
            default:
                XCTFail("Expected Parse JSON error, but received: \(error)")
            }
        }
    }
}

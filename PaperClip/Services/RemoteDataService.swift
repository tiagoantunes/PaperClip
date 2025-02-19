//
//  RemoteDataService.swift
//  PaperClip
//
//  Created by Tiago Antunes on 16/02/2025.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    /* default implementation */
}

protocol RemoteDataServiceProtocol {
    func getAdsData() async throws -> AdList
    func getAdCategories() async throws -> [AdCategory]
}

final class RemoteDataService: RemoteDataServiceProtocol {
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func getAdsData() async throws -> AdList {
        guard let urlRequest = getUrlRequestFor(.ads) else {
            throw NetworkError.invalidRequest
        }

        Logger.log(info: "Request: \(urlRequest)")

        guard
            let (data, response) = try? await session.data(for: urlRequest),
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidResponse
        }

        do {
            let adList = try JSONDecoder().decode(AdList.self, from: data)
            return adList
        } catch {
            if let decodingError = error as? DecodingError {
                throw NetworkError.parseJSON(decodingError)
            }
            throw NetworkError.unknown(error)
        }
    }

    func getAdCategories() async throws -> [AdCategory] {
        guard let urlRequest = getUrlRequestFor(.categories) else {
            throw NetworkError.invalidRequest
        }

        Logger.log(info: "Request: \(urlRequest)")

        guard
            let (data, response) = try? await session.data(for: urlRequest),
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidResponse
        }

        do {
            let adCategories = try JSONDecoder().decode([AdCategory].self, from: data)
            return adCategories
        } catch {
            if let decodingError = error as? DecodingError {
                throw NetworkError.parseJSON(decodingError)
            }
            throw NetworkError.unknown(error)
        }
    }

    private func getUrlRequestFor(_ dataType: AdDataType) -> URLRequest? {
        let urlComponents = URLComponents(string: dataType.path)

        guard let url = urlComponents?.url else { return nil }

        let headers = [
            "accept": "application/json"
        ]

        var urlRequest = URLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0
        )
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers

        return urlRequest
    }
}

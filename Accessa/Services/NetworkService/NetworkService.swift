//
//  NetworkService.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//


import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    
    private let session: URLSession

    private init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        let request = try endpoint.urlRequest()
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        try validateResponse(httpResponse, data: data)

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    private func validateResponse(_ response: HTTPURLResponse, data: Data) throws {

        let errorMessage = (try? JSONDecoder().decode(ErrorResponse.self, from: data))?.message

        switch response.statusCode {

        case 200...299:
            return

        case 401:
                //TODO: logout logic here if 401
            throw NetworkError.clientError(401, message: errorMessage)

        case 400...499:
            throw NetworkError.clientError(response.statusCode, message: errorMessage)

        case 500...599: throw NetworkError.serverError(response.statusCode, message: errorMessage)

        default:
            throw NetworkError.unknownError(response.statusCode)
        }
    }

}

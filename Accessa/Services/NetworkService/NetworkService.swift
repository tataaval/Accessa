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
    private let sessionService: SessionServiceProtocol

    private init(
        session: URLSession = .shared,
        sessionService: SessionServiceProtocol = SessionService()
    ) {
        self.session = session
        self.sessionService = sessionService
    }

    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        var request = try endpoint.urlRequest()
        
        if endpoint.requiresAuth,
            let token = sessionService.token
        {
            request.setValue(
                "Bearer \(token)",
                forHTTPHeaderField: "Authorization"
            )
        }

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

    private func validateResponse(_ response: HTTPURLResponse, data: Data)
        throws
    {

        let decoder = JSONDecoder()

        switch response.statusCode {

        case 200...299:
            return

        case 422:
            if let validationError = try? decoder.decode(
                ErrorResponse.self,
                from: data
            ) {
                throw NetworkError.validationError(validationError)
            }

            throw NetworkError.clientError(422, message: "Validation failed.")

        case 401:
            let message = (try? decoder.decode(ErrorResponse.self, from: data))?
                .message
            // TODO: logout / refresh token logic
            throw NetworkError.clientError(401, message: message)

        case 400...499:
            let message = (try? decoder.decode(ErrorResponse.self, from: data))?
                .message
            throw NetworkError.clientError(
                response.statusCode,
                message: message
            )

        case 500...599:
            let message = (try? decoder.decode(ErrorResponse.self, from: data))?
                .message
            throw NetworkError.serverError(
                response.statusCode,
                message: message
            )

        default:
            throw NetworkError.unknownError(response.statusCode)
        }
    }

}

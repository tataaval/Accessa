//
//  ErrorResponse.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import Foundation

struct ErrorResponse: Decodable {
    let message: String
    let errors: [String: [String]]?
}

extension ErrorResponse {
    nonisolated var combinedErrorMessage: String {
        guard let errors else { return message }

        return errors
            .values
            .flatMap { $0 }
            .joined(separator: "\n")
    }
}

enum NetworkError: Error {
    case invalidResponse
    case decodingFailed
    case clientError(Int, message: String?)
    case serverError(Int, message: String?)
    case validationError(ErrorResponse)
    case unknownError(Int)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .validationError(let response):
            return response.combinedErrorMessage
        case .clientError(_, let message),
            .serverError(_, let message):
            return message ?? "Something went wrong."
        case .invalidResponse:
            return "Invalid response from server."
        case .decodingFailed:
            return "Failed to process response."
        case .unknownError:
            return "Unexpected error occurred."
        }
    }
}

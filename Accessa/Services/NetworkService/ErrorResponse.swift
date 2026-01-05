//
//  ErrorResponse.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//


import Foundation

struct ErrorResponse: Decodable {
    let message: String
}

enum NetworkError: Error {
    case invalidResponse
    case decodingFailed
    case clientError(Int, message: String?)
    case serverError(Int, message: String?)
    case unknownError(Int)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
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

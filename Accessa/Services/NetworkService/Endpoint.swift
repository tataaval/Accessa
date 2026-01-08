//
//  Endpoint.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var hasQueryParameters: Bool { get }
    var parameters: [String: Any]? { get }
    var requiresAuth: Bool { get }
}

extension Endpoint {
    func urlRequest() throws -> URLRequest {
        let urlString = baseURL.absoluteString.trimmingCharacters(
            in: CharacterSet(charactersIn: "/")
        )
        let pathString = path.hasPrefix("/") ? path : "/\(path)"
        guard let url = URL(string: urlString + pathString) else {
            throw NetworkError.invalidResponse
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        var finalHeaders = headers ?? [:]
        finalHeaders["Accept"] = "application/json"
        finalHeaders["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = finalHeaders

        if let parameters = parameters {
            if hasQueryParameters {
                var components = URLComponents(
                    url: url,
                    resolvingAgainstBaseURL: false
                )
                components?.queryItems = parameters.map {
                    URLQueryItem(name: $0.key, value: "\($0.value)")
                }
                request.url = components?.url
            } else {
                request.httpBody = try JSONSerialization.data(
                    withJSONObject: parameters
                )
            }
        }

        return request
    }
}

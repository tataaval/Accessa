//
//  CardAPI.swift
//  Accessa
//
//  Created by Tatarella on 17.01.26.
//

import Foundation

enum CardAPI {
    case cardInfo
}

extension CardAPI: Endpoint {
    var path: String { "api/v1/card-page" }
    var method: HTTPMethod { .post }
    var headers: [String: String]? { nil }
    var hasQueryParameters: Bool { false }
    var requiresAuth: Bool { true }
    var parameters: [String: Any]? { nil }
}

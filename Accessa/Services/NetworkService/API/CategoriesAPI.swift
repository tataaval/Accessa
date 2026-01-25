//
//  CategoriesAPI.swift
//  Accessa
//
//  Created by Tatarella on 17.01.26.
//

import Foundation

enum CategoriesAPI {
    case categories
}

extension CategoriesAPI: Endpoint {
    var path: String { "api/v1/categories" }
    var method: HTTPMethod { .post }
    var headers: [String: String]? { nil }
    var hasQueryParameters: Bool { false }
    var requiresAuth: Bool { false }
    var parameters: [String: Any]? { nil }
}

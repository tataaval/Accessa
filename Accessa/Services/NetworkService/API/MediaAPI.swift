//
//  MediaAPI.swift
//  Accessa
//
//  Created by Tatarella on 17.01.26.
//

import Foundation

enum MediaAPI {
    case mediaItems(id: Int)
}

extension MediaAPI: Endpoint {

    var path: String {
        switch self {
        case .mediaItems:
            return "api/v1/media/get-attached-images"
        }
    }

    var method: HTTPMethod { .post }

    var headers: [String: String]? { nil }

    var hasQueryParameters: Bool { false }

    var requiresAuth: Bool { true }

    var parameters: [String: Any]? {
        switch self {
        case .mediaItems(let id):
            return [
                "reference_id": id,
                "reference_type": "1",
            ]
        }
    }
}

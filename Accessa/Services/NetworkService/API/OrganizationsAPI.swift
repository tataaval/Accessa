//
//  OrganizationsAPI.swift
//  Accessa
//
//  Created by Tatarella on 17.01.26.
//

import Foundation

enum OrganizationsAPI {
    case organizations(
        limit: Int,
        page: Int? = nil,
        searchKeyword: String? = nil
    )
    case organizationDetails(id: Int)
}

extension OrganizationsAPI: Endpoint {

    var path: String {
        switch self {
        case .organizations:
            return "api/v1/organisations"
        case .organizationDetails(let id):
            return "api/v1/organisations/\(id)"
        }
    }

    var method: HTTPMethod { .post }

    var headers: [String: String]? { nil }

    var hasQueryParameters: Bool {
        switch self {
        case .organizations:
            return true
        default:
            return false
        }
    }

    var requiresAuth: Bool { true }

    var parameters: [String: Any]? {
        switch self {
        case .organizations(let limit, let page, let searchKeyword):
            var params: [String: Any] = [
                "pager_limit": limit
            ]

            if let page { params["page"] = page }
            if let searchKeyword, !searchKeyword.isEmpty {
                params["search_keyword"] = searchKeyword
            }

            return params

        default:
            return nil
        }
    }
}

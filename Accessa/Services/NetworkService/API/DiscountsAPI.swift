//
//  DiscountsAPI.swift
//  Accessa
//
//  Created by Tatarella on 17.01.26.
//

import Foundation

enum DiscountsAPI {
    case discounts(
        limit: Int,
        page: Int? = nil,
        searchKeyword: String? = nil,
        organisationId: Int? = nil,
        categoryId: Int? = nil
    )
    case discountDetails(id: Int)
    case pinnedOffers(limit: Int)
}

extension DiscountsAPI: Endpoint {

    var path: String {
        switch self {
        case .discounts:
            return "api/v1/discounts"
        case .discountDetails(let id):
            return "api/v1/discounts/\(id)"
        case .pinnedOffers:
            return "api/v1/discounts/pinned_discounts"
        }
    }

    var method: HTTPMethod { .post }

    var headers: [String: String]? { nil }

    var hasQueryParameters: Bool {
        switch self {
        case .discounts, .pinnedOffers:
            return true
        default:
            return false
        }
    }

    var requiresAuth: Bool { true }

    var parameters: [String: Any]? {
        switch self {
        case .pinnedOffers(let limit):
            return ["limit": limit]

        case .discounts(
            let limit,
            let page,
            let searchKeyword,
            let organisationId,
            let categoryId
        ):
            var params: [String: Any] = [
                "pager_limit": limit,
                "type": 1,
            ]

            if let page { params["page"] = page }
            if let searchKeyword, !searchKeyword.isEmpty {
                params["search_keyword"] = searchKeyword
            }
            if let organisationId { params["organisation_id"] = organisationId }
            if let categoryId { params["category_id"] = categoryId }

            return params

        default:
            return nil
        }
    }
}

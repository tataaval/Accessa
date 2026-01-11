//
//  API.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import Foundation

enum API {
    case login(IdNumber: String, password: String)
    case register(
        name: String,
        IdNumber: String,
        phone: String,
        birthDate: String,
        email: String,
        password: String,
        repeatPassword: String
    )
    case forgotPassword(email: String)

    case discounts(
        limit: Int,
        page: Int? = nil,
        searchKeyword: String? = nil,
        organisationId: Int? = nil,
        categoryId: Int? = nil
    )

    case discountDetails(id: Int)

    case pinnedOffers(limit: Int)

    case organizations(
        limit: Int,
        page: Int? = nil,
        searchKeyword: String? = nil
    )

    case categories

    case mediaItems(id: Int)
}

extension API: Endpoint {

    var baseURL: URL {
        guard let url = URL(string: "https://api.eyc.artmedia.space") else {
            fatalError("Invalid base URL")
        }
        return url
    }

    var path: String {
        switch self {
        case .login:
            return "api/v1/auth/login"
        case .register:
            return "api/v1/registration/reg"
        case .forgotPassword:
            return "api/v1/password-forgot"
        case .discounts:
            return "api/v1/discounts"
        case .discountDetails(let id):
            return "api/v1/discounts/\(id)"
        case .pinnedOffers:
            return "api/v1/discounts/pinned_discounts"
        case .organizations:
            return "api/v1/organisations"
        case .categories:
            return "api/v1/categories"
        case .mediaItems:
            return "api/v1/media/get-attached-images"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .login, .register, .forgotPassword, .pinnedOffers, .organizations,
            .categories,
            .discounts, .discountDetails, .mediaItems:
            return .post
        default:
            return .get
        }
    }

    //TODO: - გადახედე ამას
    var headers: [String: String]? {
        nil
    }

    //TODO: - აპის მეთოდები თითქმის ყველა Post-ია, თუ გაასწორებენ ეს წაშალე
    var hasQueryParameters: Bool {
        switch self {
        case .pinnedOffers, .organizations, .discounts:
            return true
        default:
            return false
        }
    }

    var requiresAuth: Bool {
        switch self {
        case .login, .register, .forgotPassword:
            return false
        default:
            return true
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .login(let idNumber, let password):
            return ["id_number": idNumber, "password": password]
        case .register(
            let name,
            let idNumber,
            let phone,
            let birthDate,
            let email,
            let password,
            let repeatPassword
        ):
            return [
                "id_number": idNumber,
                "mobile": phone,
                "full_name_en": name,
                "email": email,
                "password": password,
                "repeat_password": repeatPassword,
                "birth_date": birthDate,
            ]
        case .forgotPassword(let email):
            return ["email": email]

        case .pinnedOffers(let limit):
            return ["limit": limit]

        case .organizations(
            let limit,
            let page,
            let searchKeyword
        ):
            var params: [String: Any] = [
                "pager_limit": limit
            ]

            if let page {
                params["page"] = page
            }

            if let searchKeyword, !searchKeyword.isEmpty {
                params["search_keyword"] = searchKeyword
            }

            return params

        case .discounts(
            let limit,
            let page,
            let searchKeyword,
            let organisationId,
            let categoryId
        ):
            var params: [String: Any] = [
                "pager_limit": limit
            ]

            if let page {
                params["page"] = page
            }

            if let searchKeyword, !searchKeyword.isEmpty {
                params["search_keyword"] = searchKeyword
            }

            if let organisationId {
                params["organisation_id"] = organisationId
            }

            if let categoryId {
                params["category_id"] = categoryId
            }

            return params

        case .mediaItems(let id):
            return [
                "reference_id": id,
                "reference_type": "1",
            ]
        default:
            return nil
        }
    }

}

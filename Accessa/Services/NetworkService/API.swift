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

    case discounts(limit: Int)
    case pinnedOffers(limit: Int)

    case organizations(limit: Int)
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
        case .pinnedOffers:
            return "api/v1/discounts/pinned_discounts"
        case .organizations:
            return "api/v1/organisations"
        }
    }

    var method: HTTPMethod {
        switch self {
            case .login, .register, .forgotPassword, .pinnedOffers, .organizations, .discounts:
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
                
            case .organizations(let limit):
                return ["pager_limit": limit]
                
            case .discounts(let limit):
                return ["pager_limit": limit]
        }
    }

}

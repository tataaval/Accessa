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

    case discounts
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
        case .discounts:
            return "api/v1/discounts"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .login, .register:
            return .post
        default:
            return .get
        }
    }

    var headers: [String: String]? {
        nil
    }

    var requiresAuth: Bool {
        switch self {
        case .login, .register:
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

        default:
            return nil
        }
    }

}

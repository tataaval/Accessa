//
//  AuthAPI.swift
//  Accessa
//
//  Created by Tatarella on 17.01.26.
//

import Foundation

enum AuthAPI {
    case login(idNumber: String, password: String)
    case register(
        name: String,
        idNumber: String,
        phone: String,
        birthDate: String,
        email: String,
        password: String,
        repeatPassword: String
    )
    case forgotPassword(email: String)
}

extension AuthAPI: Endpoint {

    var path: String {
        switch self {
        case .login:
            return "api/v1/auth/login"
        case .register:
            return "api/v1/registration/reg"
        case .forgotPassword:
            return "api/v1/password-forgot"
        }
    }

    var method: HTTPMethod { .post }

    var headers: [String: String]? { nil }

    var hasQueryParameters: Bool { false }

    var requiresAuth: Bool { false }

    var parameters: [String: Any]? {
        switch self {
        case .login(let idNumber, let password):
            return [
                "id_number": idNumber,
                "password": password,
            ]

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
        }
    }
}

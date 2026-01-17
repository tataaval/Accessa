//
//  ProfileAPI.swift
//  Accessa
//
//  Created by Tatarella on 17.01.26.
//

import Foundation

enum ProfileAPI {
    case profileInfo
    case deleteProfile
    case resetPassword(
        curentPassword: String,
        password: String,
        repeatPassword: String
    )
    case updateMobile(mobile: String)
    case verifyMobile(mobile: String, code: String)
}

extension ProfileAPI: Endpoint {

    var path: String {
        switch self {
        case .deleteProfile:
            return "api/v1/student-profile/deactivation"
        case .resetPassword:
            return "api/v1/student-profile/update-password"
        case .profileInfo:
            return "api/v1/whoami"
        case .updateMobile:
            return "api/v1/student-profile/update-mobile"
        case .verifyMobile:
            return "api/v1/student-profile/verify-mobile"
        }
    }

    var method: HTTPMethod { .post }

    var headers: [String: String]? { nil }

    var hasQueryParameters: Bool { false }

    var requiresAuth: Bool { true }

    var parameters: [String: Any]? {
        switch self {
        case .resetPassword(
            let currentPassword,
            let password,
            let repeatPassword
        ):
            return [
                "current_password": currentPassword,
                "password": password,
                "repeat_password": repeatPassword,
            ]

        case .updateMobile(let mobile):
            return ["mobile": mobile]

        case .verifyMobile(let mobile, let code):
            return [
                "mobile": mobile,
                "verification_code": code,
            ]

        default:
            return nil
        }
    }
}

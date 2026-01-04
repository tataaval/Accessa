//
//  API.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import Foundation

enum API {
    case login(IdNumber: Int, password: String)
    
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
            case .discounts:
                return "api/v1/discounts"
        }
    }
    

    var method: HTTPMethod {
        switch self {
        case .login:
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
            case .login:
            return false
        default:
            return true
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .login(let idNumber, let password):
            return ["id_number": idNumber, "password": password]

        default:
            return nil
        }
    }
    
}

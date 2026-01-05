//
//  LoginResponseModel.swift
//  Accessa
//
//  Created by Tatarella on 05.01.26.
//

struct LoginResponseModel: Decodable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "access_token"
    }
}

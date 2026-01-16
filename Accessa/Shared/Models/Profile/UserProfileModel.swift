//
//  UserProfileModel.swift
//  Accessa
//
//  Created by Tatarella on 16.01.26.
//

struct UserProfileModel: Decodable {
    let idNumber: String
    let fullName: String?
    let email: String
    let emailVerified: Bool
    let mobile: String
    let mobileVerified: Bool

    enum CodingKeys: String, CodingKey {
        case idNumber = "id_number"
        case fullName = "full_name_en"
        case email
        case emailVerified = "email_verified"
        case mobile
        case mobileVerified = "mobile_verified"
    }
}


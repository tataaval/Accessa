//
//  CardInfoModel.swift
//  Accessa
//
//  Created by Tatarella on 14.01.26.
//


struct CardInfoModel: Decodable {
    let fullName: String
    let expirationDate: String
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case expirationDate = "expiration_date"
    }
}


struct DeleteProfileResponseModel: Decodable {
    let message: String
}

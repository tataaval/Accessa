//
//  OrganizationInfo.swift
//  Accessa
//
//  Created by Tatarella on 12.01.26.
//


struct OrganizationInfo: Decodable {
    let image: Media?
    let city: String

    enum CodingKeys: String, CodingKey {
        case image
        case city
    }
}

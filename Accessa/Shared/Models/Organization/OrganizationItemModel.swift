//
//  OrganizationItemModel.swift
//  Accessa
//
//  Created by Tatarella on 08.01.26.
//


struct OrganizationItemModel: Decodable, Identifiable {
    let id: Int
    let organizationPageItemId: Int
    let companyName: String
    let image: Media?
    let city: String

    enum CodingKeys: String, CodingKey {
        case id
        case organizationPageItemId = "organisation_page_item_id"
        case companyName = "company_name"
        case image
        case city
    }
}

extension OrganizationItemModel{
    var imageUrl: String? {
        image?.url
    }
}

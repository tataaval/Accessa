//
//  OrganisationItemModel.swift
//  Accessa
//
//  Created by Tatarella on 08.01.26.
//


struct OrganisationItemModel: Decodable, Identifiable {
    let id: Int
    let organisationPageItemId: Int
    let companyName: String
    let image: Media?
    let city: String

    enum CodingKeys: String, CodingKey {
        case id
        case organisationPageItemId = "organisation_page_item_id"
        case companyName = "company_name"
        case image
        case city
    }
}

extension OrganisationItemModel{
    var imageUrl: String? {
        image?.url
    }
}

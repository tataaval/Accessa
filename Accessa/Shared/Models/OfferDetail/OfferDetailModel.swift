//
//  OfferDetailModel.swift
//  Accessa
//
//  Created by Tatarella on 10.01.26.
//

import Foundation

// MARK: - OfferDetailModel
struct OfferDetailModel: Decodable, Identifiable {

    let id: Int
    let title: String
    let discount: Int
    let descriptionHTML: String
    let cities: [City]
    let organisation: Organisation
    let endDate: String

    // MARK: - Identifiable
    var itemId: Int { id }

    enum CodingKeys: String, CodingKey {
        case id = "item_id"
        case title
        case discount
        case descriptionHTML = "desc"
        case cities
        case organisation
        case endDate = "end_date"
    }
}

extension OfferDetailModel {

    var discountText: String {
        "\(discount)% Off"
    }

    var organizationTitle: String {
        organisation.title
    }

    var imageURL: String? {
        organisation.image?.url
    }

    var cityNames: String {
        if cities.count == 1 {
            "\(cities.first!.title)"
        } else {
            cities.map { $0.title }.joined(separator: ", ")
        }
    }
}

//
//  OfferModel.swift
//  Accessa
//
//  Created by Tatarella on 08.01.26.
//

struct OfferModel: Decodable, Identifiable {
    let id: Int
    let title: String
    let discount: Int
    let endDate: String
    let image: Media?
    let organisation: Organisation

    enum CodingKeys: String, CodingKey {
        case id = "item_id"
        case title
        case discount
        case endDate = "end_date"
        case image
        case organisation
    }
}

extension OfferModel {
    var discountText: String {
        "\(discount)% Off"
    }

    var organisationTitle: String {
        organisation.title
    }

    var imageURL: String? {
        image?.url
    }
}

//
// OffersResponseModel.swift
//  Accessa
//
//  Created by Tatarella on 09.01.26.
//


struct OffersResponseModel: Decodable {
    let data: [OfferModel]
    let meta: PaginationMetaModel
}

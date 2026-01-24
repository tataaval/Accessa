//
//  Offer.swift
//  Accessa
//
//  Created by Tatarella on 23.01.26.
//


struct Offer: Codable {
    let id: Int
    let title: String
    let discount: Int
    let organization: String
    let coordinate: Coordinate
    let category: OfferCategory
}

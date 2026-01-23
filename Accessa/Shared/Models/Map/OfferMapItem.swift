//
//  OfferMapItem.swift
//  Accessa
//
//  Created by Tatarella on 22.01.26.
//

import MapKit

struct OfferMapItem: Identifiable {
    let id: Int
    let title: String
    let discount: Int
    let organization: String
    let coordinate: CLLocationCoordinate2D

    var discountText: String {
        return "-\(discount)%"
    }
}

extension OfferMapItem {
    init(offer: Offer) {
        self.id = offer.id
        self.title = offer.title
        self.discount = offer.discount
        self.organization = offer.organization
        self.coordinate = CLLocationCoordinate2D(
            latitude: offer.coordinate.latitude,
            longitude: offer.coordinate.longitude
        )
    }
}

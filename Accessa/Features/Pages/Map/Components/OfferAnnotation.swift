//
//  OfferAnnotation.swift
//  Accessa
//
//  Created by Tatarella on 22.01.26.
//

import MapKit

final class OfferAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let offer: OfferMapItem

    init(offer: OfferMapItem) {
        self.offer = offer
        self.coordinate = offer.coordinate
    }

    var title: String? { offer.title }
    var discountText: String { "-\(offer.discount)%" }
}

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

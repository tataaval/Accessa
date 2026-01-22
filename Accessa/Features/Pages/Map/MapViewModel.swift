//
//  MapViewModel.swift
//  Accessa
//
//  Created by Tatarella on 21.01.26.
//

import Combine
import CoreLocation
import Foundation

final class MapViewModel: ObservableObject {
    @Published var offers: [OfferMapItem] =
        [
            OfferMapItem(
                id: 309,
                title: "15% Off on Official Merchandise",
                discount: 15,
                organization: "Georgia Starts Here",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.7151,
                    longitude: 44.8271
                )
            ),
            OfferMapItem(
                id: 285,
                title: "20% off on Tennis Court Rentals",
                discount: 20,
                organization: "Tennis Centre",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.7325,
                    longitude: 44.8012
                )
            ),
            OfferMapItem(
                id: 341,
                title: "giorgis shetavazeba",
                discount: 60,
                organization: "giorgis kompania",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.7050,
                    longitude: 44.7900
                )
            ),
            OfferMapItem(
                id: 311,
                title: "20-30% Off on Winter Sports & Tours",
                discount: 30,
                organization: "skiclub GE",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.7202,
                    longitude: 44.7834
                )
            ),
            OfferMapItem(
                id: 307,
                title: "20% Off on Gldani-Nadzaladevi Sports Complex Services",
                discount: 20,
                organization:
                    "Tbilisi Gldani-Nadzaladevi Sports Complex Center",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.7916,
                    longitude: 44.8337
                )
            ),
            OfferMapItem(
                id: 305,
                title: "20% off on Theatre Performances",
                discount: 20,
                organization: "Sandro Akhmeteli Theatre",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.7269,
                    longitude: 44.7985
                )
            ),
            OfferMapItem(
                id: 303,
                title: "20% off on Multifunctional Public Center Services",
                discount: 20,
                organization: "Multifunctional Public Center",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.7122,
                    longitude: 44.7831
                )
            ),
            OfferMapItem(
                id: 301,
                title: "20% off on Library Services",
                discount: 20,
                organization: "Tbilisi central library",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.7095,
                    longitude: 44.8016
                )
            ),
            OfferMapItem(
                id: 299,
                title: "20% Off on National Youth Palace Services",
                discount: 20,
                organization: "National Youth Palace",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.6977,
                    longitude: 44.7994
                )
            ),
            OfferMapItem(
                id: 297,
                title: "20% off on Tbilisi's Museums",
                discount: 20,
                organization: "Union of Tbilisi Museums",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.6953,
                    longitude: 44.8019
                )
            ),
            OfferMapItem(
                id: 295,
                title: "20% Off on Theatre Performances",
                discount: 20,
                organization:
                    "Sandro Mrevlishvili Tbilisi Municipal Professional Theatre",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.7200,
                    longitude: 44.7920
                )
            ),
            OfferMapItem(
                id: 293,
                title: "20% off on Contemporary Ballet Performances",
                discount: 20,
                organization: "Tbilisi Ballet",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.7160,
                    longitude: 44.7810
                )
            ),
            OfferMapItem(
                id: 291,
                title: "20% Off on Fitness and Swimming",
                discount: 20,
                organization: "Isani-Samgori Complex Sports Center",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.6860,
                    longitude: 44.8640
                )
            ),
            OfferMapItem(
                id: 287,
                title: "20% off on Gymnastics Training",
                discount: 20,
                organization: "Gymnastics Development Sports Center",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.6990,
                    longitude: 44.8450
                )
            ),
        ]
}

//
//  OffersListView.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI

struct OffersListView: View {
    let router: OffersRouter

    var body: some View {
        VStack {
            Button("Offer 1") {
                router.openOffer(id: 1)
            }
        }
        .navigationTitle("Offers")
    }
}

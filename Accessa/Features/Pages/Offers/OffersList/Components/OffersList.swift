//
//  OffersList.swift
//  Accessa
//
//  Created by Tatarella on 09.01.26.
//

import SwiftUI

struct OffersList: View {

    //MARK: - Properties
    let offers: [OfferModel]
    let seeDetails: (_ offerId: Int) -> Void

    //MARK: - Grid Layout
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)

    //MARK: - Body
    var body: some View {

        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(offers) { offer in
                OfferCard(offer: offer, seeDetails: seeDetails)
            }
        }
        .padding(.horizontal)
    }
}

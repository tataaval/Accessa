//
//  LastChanceSection.swift
//  Accessa
//
//  Created by Tatarella on 08.01.26.
//

import SwiftUI

struct LastChanceSection: View {
    // MARK: - Properties
    let offers: [OfferModel]
    let seeDetails: (_ offerId: Int) -> Void

    //MARK: - Grid Layout
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)

    //MARK: - Body
    var body: some View {
        VStack(spacing: 16) {
            sectionHeader
            itemsList
        }
    }
}


private extension LastChanceSection {
    var sectionHeader: some View {
        HStack(alignment: .center) {
            Text("Last Chance")
                .font(.app(size: .lg, weight: .semibold))
                .foregroundStyle(.colorGray900)

            Image(systemName: "clock.fill")
                .resizable()
                .foregroundStyle(.white)
                .padding(6)
                .frame(width: 24, height: 24)
                .background(.colorError)
                .cornerRadius(12)
        }
        .padding(.horizontal)
    }
    
    var itemsList: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(offers) { offer in
                LastChanceCard(offer: offer, seeDetails: seeDetails)
            }
        }
        .padding(.horizontal)
    }
}

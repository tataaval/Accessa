//
//  LastChanceCard.swift
//  Accessa
//
//  Created by Tatarella on 08.01.26.
//

import SwiftUI

struct LastChanceCard: View {
    //MARK: - Properties
    let offer: OfferModel
    let seeDetails: (_ offerId: Int) -> Void

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            imageSection
            contentSection
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .colorGray900.opacity(0.1), radius: 3, y: 2)
    }
}


private extension LastChanceCard {
    var imageSection: some View {
        ZStack(alignment: .topTrailing) {
            if let offerImageURL = offer.imageURL {
                ImageItem(image: offerImageURL)
                    .frame(height: 120)
                    .clipped()
            } else {
                ImagePlaceholder()
                    .frame(height: 120)
                    .clipped()
            }

            Text(offer.discountText)
                .font(.app(size: .xs, weight: .semibold))
                .padding(6)
                .background(.colorError)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(8)
        }
    }
    
    var contentSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(offer.title)
                .font(.app(size: .sm, weight: .semibold))
                .foregroundStyle(.colorGray900)
                .lineLimit(2)

            Text(offer.organisationTitle)
                .font(.app(size: .xs))
                .foregroundStyle(.colorGray500)

            Spacer()
            seeMoreButon
        }
        .padding()
    }
    
    var seeMoreButon: some View {
        Button {
            seeDetails(offer.id)
        } label: {
            Text("See More")
                .frame(maxWidth: .infinity)
                .padding(8)
                .background(.colorError)
                .font(.app(size: .sm, weight: .semibold))
                .foregroundColor(.white)
                .cornerRadius(12)
        }
    }
}

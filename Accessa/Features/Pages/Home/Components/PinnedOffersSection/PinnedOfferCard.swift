//
//  PinnedOfferCard.swift
//  Accessa
//
//  Created by Tatarella on 08.01.26.
//
import SwiftUI

struct PinnedOfferCard: View {
    //MARK: - Properties
    let offer: OfferModel
    let seeDetails: (_ offerId: Int) -> Void

    //MARK: - Body
    var body: some View {
        VStack {
            imageSection
            descriptionSection
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .colorGray900.opacity(0.5), radius: 3, y: 2)
    }
}

private extension PinnedOfferCard {
    var imageSection: some View {
        ZStack(alignment: .topTrailing) {
            itemImage
            discountInfo
        }
    }

    @ViewBuilder
    var itemImage: some View {
        if let offerImageURL = offer.imageURL {
            ImageItem(image: offerImageURL)
                .frame(height: 176)
                .clipped()
        } else {
            ImagePlaceholder()
                .frame(height: 176)
                .clipped()
        }
    }
    
    var discountInfo: some View {
        HStack {
            HStack(spacing: 4) {
                Image(systemName: "pin.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 10, height: 12)
                Text("Pinned")
                    .font(.app(size: .xs, weight: .bold))
            }
            .padding(6)
            .background(Color.colorSecondary)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(8)
            Spacer()
            Text(offer.discountText)
                .font(.app(size: .xs, weight: .bold))
                .padding(6)
                .background(Color.colorError)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(8)
        }
    }
    
    var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(offer.title)
                .font(.app(size: .base, weight: .bold))
                .foregroundColor(.colorGray900)

            Text(offer.organizationTitle)
                .font(.app(size: .sm))
                .foregroundColor(.colorGray500)

           seeMoreButton
        }
        .padding()
    }
    
    var seeMoreButton: some View {
        Button {
            seeDetails(offer.id)
        } label: {
            Text("See Details")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.colorPrimary)
                .font(.app(size: .sm, weight: .semibold))
                .foregroundColor(.white)
                .cornerRadius(12)
        }
    }
}

//
//  OrganizationOffer.swift
//  Accessa
//
//  Created by Tatarella on 13.01.26.
//

import SwiftUI

struct OrganizationOffer: View {
    //MARK: - Properties
    let offer: OfferModel
    let note: String
    let onSeeMore: (_ id: Int) -> Void

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(offer.title)
                    .font(.app(size: .base, weight: .semibold))
                    .foregroundStyle(.colorGray900)
                Spacer()
                Image(systemName: "gift")
                    .foregroundStyle(.colorGray900)
            }

            Divider()

            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 6) {
                    Label("valid until \(offer.endDate)", systemImage: "clock")
                        .font(.app(size: .xs, weight: .semibold))
                        .foregroundStyle(.colorGray500)
                    Label(note, systemImage: "info.circle")
                        .font(.app(size: .xs, weight: .semibold))
                        .foregroundStyle(.colorGray500)
                }
                .font(.caption)
                .foregroundStyle(.secondary)

                Spacer()

                Button("See Details") { onSeeMore(offer.id) }
                    .font(.app(size: .xs, weight: .semibold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .background(.colorPrimary)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 0)
    }
}

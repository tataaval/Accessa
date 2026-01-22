//
//  OfferPreviewCard.swift
//  Accessa
//
//  Created by Tatarella on 22.01.26.
//

import SwiftUI

struct OfferPreviewCard: View {
    //MARK: - Properties
    let title: String
    let discountText: String
    let organization: String
    let onGoDetails: () -> Void
    let onClose: () -> Void

    //MARK: - Body
    var body: some View {
        VStack(spacing: 12) {

            HStack(alignment: .top, spacing: 12) {

                ZStack {
                    Circle()
                        .fill(Color.colorPrimary)
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 2)
                        )

                    Text(discountText)
                        .font(.app(size: .xs, weight: .bold))
                        .foregroundStyle(.white)
                }
                .frame(width: 44, height: 44)

                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.app(size: .sm, weight: .semibold))
                        .foregroundStyle(.colorGray900)
                        .lineLimit(2)

                    Text(organization)
                        .font(.app(size: .xs, weight: .bold))
                        .foregroundStyle(.colorPrimary)
                }

                Spacer()

                Button(action: onClose) {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.colorGray600)
                        .frame(width: 28, height: 28)
                        .background(Color.colorGray200)
                        .clipShape(Circle())
                }
            }

            Button(action: onGoDetails) {
                Text("Go details")
                    .font(.app(size: .sm, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.colorPrimary)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.12), radius: 12, x: 0, y: 6)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.colorGray200, lineWidth: 1)
        )
    }
}

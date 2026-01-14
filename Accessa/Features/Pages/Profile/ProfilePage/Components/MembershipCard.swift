//
//  MembershipCard.swift
//  Accessa
//
//  Created by Tatarella on 14.01.26.
//

import SwiftUI

struct MembershipCard: View {
    //MARK: - Properties
    let cardInfo: CardInfoModel

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text("Cardholder Name")
                .font(.app(size: .sm, weight: .semibold))
                .foregroundColor(.white.opacity(0.8))

            Text(cardInfo.fullName)
                .font(.app(size: .lg, weight: .semibold))
                .foregroundColor(.white)

            Spacer()

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Valid Until")
                        .font(.app(size: .sm, weight: .semibold))
                        .foregroundColor(.white.opacity(0.8))

                    Text(cardInfo.expirationDate)
                        .font(.app(size: .lg, weight: .semibold))
                        .foregroundColor(.white)
                }

                Spacer()

                HStack(spacing: 6) {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 8, height: 8)

                    Text("ACTIVE")
                        .font(.app(size: .base, weight: .semibold))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(.white.opacity(0.3))
                .clipShape(Capsule())
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 140)
        .padding(24)
        .background(.colorSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(color: .black.opacity(0.15), radius: 20, y: 10)
        .padding(.horizontal)
    }
}

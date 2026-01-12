//
//  OrganizationListCard.swift
//  Accessa
//
//  Created by Tatarella on 11.01.26.
//

import SwiftUI

struct OrganizationListCard: View {

    //MARK: - Properties
    let organization: OrganizationItemModel
    let seeDetails: (_ organizationPageId: Int, _ organizationItemId: Int) -> Void

    //MARK: - Body
    var body: some View {
        Button {
            seeDetails(organization.organizationPageItemId, organization.id)
        } label: {
            HStack(spacing: 16) {

                logoView

                VStack(alignment: .leading, spacing: 6) {
                    Text(organization.companyName)
                        .font(.app(size: .base, weight: .semibold))
                        .foregroundStyle(.colorGray900)

                    HStack(spacing: 6) {
                        Image(systemName: "location")
                            .font(.system(size: 14))
                            .foregroundStyle(.colorGray500)

                        Text(organization.city)
                            .font(.app(size: .sm))
                            .foregroundStyle(.colorGray500)
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.colorGray500)
            }
            .padding(16)
            .background(cardBackground)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Helper Views
    @ViewBuilder
    private var logoView: some View {
        if let imageURL = organization.imageUrl {
            ImageItem(image: imageURL)
                .frame(width: 56, height: 56)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 12))
        } else {
            ImagePlaceholder()
                .frame(width: 56, height: 56)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(Color.white)
            .shadow(
                color: Color.black.opacity(0.06),
                radius: 10,
                x: 0,
                y: 4
            )
    }
}

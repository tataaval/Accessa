//
//  OrganizationCard.swift
//  Accessa
//
//  Created by Tatarella on 08.01.26.
//

import SwiftUI

struct OrganizationCard: View {

    //MARK: - Properties
    let organization: OrganizationItemModel
    let seeOrganizationDetails: (_ OrganizationId: Int) -> Void

    //MARK: - Body
    var body: some View {
        Button {
            seeOrganizationDetails(organization.id)
        } label: {
            VStack {
                imageSection
                nameSection
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 132)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .colorGray900.opacity(0.2), radius: 3, y: 2)
        }
    }
}

private extension OrganizationCard {
    @ViewBuilder
    var imageSection: some View {
        if let imageUrl = organization.imageUrl, !imageUrl.isEmpty {
            ImageItem(image: imageUrl)
                .scaledToFit()
                .frame(width: 64, height: 64)
        } else {
            Image(systemName: "photo")
                .scaledToFit()
                .foregroundStyle(.colorPrimary)
                .frame(width: 64, height: 64)
        }
    }
    
    var nameSection: some View {
        Text(organization.companyName)
            .font(.app(size: .xs, weight: .bold))
            .foregroundStyle(.colorGray900)
            .multilineTextAlignment(.center)
    }
}

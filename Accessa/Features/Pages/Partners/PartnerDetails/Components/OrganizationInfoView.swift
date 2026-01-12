//
//  OrganizationInfoView.swift
//  Accessa
//
//  Created by Tatarella on 12.01.26.
//

import SwiftUI

struct OrganizationInfoView: View {
    //MARK: - Properties
    let logo: String?
    let title: String
    let desc: String?
    let address: String?

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(spacing: 16) {
                logoView
                organizationInfo

                Spacer()
            }
            if let desc {
                Text(desc)
                    .font(.app(size: .sm))
                    .foregroundStyle(.colorGray900)
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.1), radius: 10, y: 4)
        .padding()
    }
}

private extension OrganizationInfoView {
    @ViewBuilder
    private var logoView: some View {
        if let imageURL = logo {
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
    
    private var organizationInfo: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.app(size: .lg, weight: .bold))
                .foregroundStyle(.colorGray900)
            location
        }
    }
    
    @ViewBuilder
    private var location: some View {
        if let address {
            HStack(alignment: .top, spacing: 6) {
                Image(systemName: "location.north.circle")
                    .font(.system(size: 14))
                    .foregroundStyle(.colorGray500)
                
                Text(address)
                    .font(.app(size: .xs))
                    .foregroundStyle(.colorGray500)
            }
        }
    }
}

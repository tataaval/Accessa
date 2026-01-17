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
    let email: String?
    let phone: String?

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(alignment: .top, spacing: 16) {
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
        .padding(.horizontal)
    }
}

extension OrganizationInfoView {
    @ViewBuilder
    private var logoView: some View {
        if let imageURL = logo {
            ImageItem(image: imageURL)
                .frame(width: 70, height: 70)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 12))
        } else {
            ImagePlaceholder()
                .frame(width: 70, height: 70)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    private var organizationInfo: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.app(size: .lg, weight: .bold))
                .foregroundStyle(.colorGray900)
            locationInfo
            phoneInfo
            emailInfo
        }
    }

    @ViewBuilder
    private var locationInfo: some View {
        if let address {
            infoItem(icon: "location.north.circle", text: address)
        }
    }

    @ViewBuilder
    private var phoneInfo: some View {
        if let phone {
            infoItem(icon: "phone", text: phone)
        }
    }

    @ViewBuilder
    private var emailInfo: some View {
        if let email {
            infoItem(icon: "envelope", text: email)
        }
    }

    private func infoItem(icon: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundStyle(.colorGray500)

            Text(text)
                .font(.app(size: .xs))
                .foregroundStyle(.colorGray500)
        }
    }
}

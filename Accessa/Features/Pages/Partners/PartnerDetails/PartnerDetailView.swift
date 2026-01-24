//
//  PartnerDetailView.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI

struct PartnerDetailView: View {
    //MARK: - StateObject
    @StateObject var viewModel: PartnerDetailViewModel

    // MARK: - Properties
    let router: OfferRouting

    //MARK: - Body
    var body: some View {
        ZStack {
            Color.colorGray200.ignoresSafeArea()

            if let organization = viewModel.organization {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        CoverView(cover: organization.coverImage)
                        OrganizationInfoView(
                            logo: organization.logoImage,
                            title: organization.title,
                            desc: organization.desc,
                            address: organization.address,
                            email: organization.email,
                            phone: organization.mobile
                        )
                        SocialsView(
                            companyURL: organization.companyURL,
                            tiktokURL: organization.tiktokURL,
                            instagramURL: organization.instagramURL,
                            facebookURL: organization.facebookURL
                        )
                        TabsView(
                            offers: viewModel.offers,
                            about: viewModel.attributedDescription
                        ) { offerId in
                            router.openOffer(id: offerId)
                        }
                    }
                }
            } else {
                LoadingOverlay(text: "Loading Organization...")
            }
        }
        .task {
            await viewModel.loadAllData()
        }
        .alert(
            "Error",
            isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )
        ) {
            Button("Retry") {
                Task {
                    await viewModel.loadAllData()
                }
            }
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "An unknown error occurred")
        }

    }
}

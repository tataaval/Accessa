//
//  PartnerDetailView.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI

struct PartnerDetailView: View {
    //MARK: - StateObject
    @StateObject private var viewModel: PartnerDetailViewModel

    //MARK: - Init
    init(organizationPageId: Int, organizationItemId: Int) {
        _viewModel = StateObject(
            wrappedValue: PartnerDetailViewModel(
                organizationPageId: organizationPageId,
                organizationItemId: organizationItemId,
                networkService: NetworkService.shared
            )
        )
    }

    //MARK: - Body
    var body: some View {
        ZStack {
            Color.colorGray200.ignoresSafeArea()

            if let organization = viewModel.organization {
                ScrollView {
                    VStack(alignment: .leading) {
                        CoverView(cover: organization.coverImage)
                        OrganizationInfoView(
                            logo: organization.logoImage,
                            title: organization.title,
                            desc: organization.desc,
                            address: organization.address
                        )
                        SocialsView(
                            companyURL: organization.companyURL,
                            tiktokURL: organization.tiktokURL,
                            instagramURL: organization.instagramURL,
                            facebookURL: organization.facebookURL
                        )
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

struct SocialsView: View {
    //MARK: - properties
    let companyURL: String?
    let tiktokURL: String?
    let instagramURL: String?
    let facebookURL: String?

    //MARK: - Body
    var body: some View {
        HStack(spacing: 12) {
            if let companyURL {
                SocialsLinkButton(
                    icon: "globe",
                    title: "Website",
                    url: companyURL
                )
            }
            if let tiktokURL {
                SocialsLinkButton(
                    icon: "globe",
                    title: "Tiktok",
                    url: tiktokURL
                )
            }
            if let instagramURL {
                SocialsLinkButton(
                    icon: "globe",
                    title: "Instagram",
                    url: instagramURL
                )
            }
            if let facebookURL {
                SocialsLinkButton(
                    icon: "globe",
                    title: "Facebook",
                    url: facebookURL
                )
            }
        }
        .padding(.horizontal)
    }
}

struct SocialsLinkButton: View {
    //MARK: - Properties
    let icon: String
    let title: String
    let url: String

    //MARK: - Body
    var body: some View {
        if let url = URL(string: url) {
            Link(destination: url) {
                content
            }
        } else {
            content
                .opacity(0.4)
        }
    }

    private var content: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.colorPrimary)

            Text(title)
                .font(.app(size: .sm, weight: .bold))
                .foregroundColor(.colorPrimary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 10, y: 4)
    }
}

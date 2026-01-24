//
//  HomeView.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI

struct HomeView: View {
    //MARK: - Properties
    @StateObject var viewModel: HomeViewModel
    
    let router: HomeRouter

    //MARK: - Body
    var body: some View {
        ZStack {
            Color.colorGray200.ignoresSafeArea()

            if viewModel.pinnedOffers.isEmpty && viewModel.isLoading {
                VStack {
                    ProgressView()
                        .scaleEffect(1.2)
                        .tint(.colorPrimary)
                    Text("Loading...")
                        .font(.app(size: .sm))
                        .foregroundStyle(.gray)
                        .padding(.top, 8)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 24) {
                        HeaderView()
                            .ignoresSafeArea(edges: .top)

                        PinnedOffersSection(
                            offers: viewModel.pinnedOffers,
                            seeDetails: { id in router.openOffer(id: id) }
                        )

                        OrganizationsSection(
                            organizations: viewModel.organizations,
                            seeOrganizationDetails: { organizationPageId, organizationItemId in
                                router.openOrganization(organizationPageId: organizationPageId, organizationItemId: organizationItemId)
                            }
                        )

                        LastChanceSection(offers: viewModel.lastChanceOffers) {
                            id in
                            router.openOffer(id: id)
                        }
                    }
                }
                .ignoresSafeArea(edges: .top)
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
            Button("Retry") { Task { await viewModel.loadAllData() } }
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "An unknown error occurred")
        }
    }
}

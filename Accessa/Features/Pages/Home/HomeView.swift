//
//  HomeView.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI

struct HomeView: View {

    @StateObject private var viewModel: HomeViewModel

    //MARK: - Properties
    let router: HomeRouter

    //MARK: - Init
    init(router: HomeRouter) {
        self.router = router
        _viewModel = StateObject(
            wrappedValue: HomeViewModel(networkService: NetworkService.shared)
        )
    }

    //MARK: - Body
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                HeaderView()
                    .ignoresSafeArea(edges: .top)
                PinnedOffersSection(
                    offers: viewModel.pinnedOffers,
                    seeDetails: { id in
                        router.openOffer(id: id)
                    }
                )
                OrganizationsSection(
                    organizations: viewModel.organizations,
                    seeOrganizationList: {
                        router.openOrganizations()
                    },
                    seeOrganizationDetails: { id in
                        router.openOrganization(id: id)
                    }
                )
                LastChanceSection(offers: viewModel.lastChanceOffers) { id in
                    router.openOffer(id: id)
                }
            }
        }
        .task {
            await viewModel.loadAllData()
        }
        .ignoresSafeArea(edges: .top)
        .background(.colorGray200)
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

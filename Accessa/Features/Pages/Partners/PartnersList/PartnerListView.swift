//
//  PartnerListView.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI

struct PartnerListView: View {
    // MARK: - StateObject
    @StateObject private var viewModel: PartnerListViewModel

    // MARK: - Properties
    let router: PartnersRouter

    // MARK: - Init
    init(router: PartnersRouter) {
        self.router = router
        _viewModel = StateObject(
            wrappedValue: PartnerListViewModel(
                networkService: NetworkService.shared
            )
        )
    }

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SearchHeaderView {
                SearchField(
                    text: $viewModel.searchText,
                    placeholder: "Search Organizations..."
                )
                .padding(.horizontal)
            }

            Divider()
            ZStack {
                if !viewModel.organizations.isEmpty {
                    resultsListView
                } else if !viewModel.isLoading {
                    EmptyStateText(text: "No Offers Found")
                }

                if viewModel.isLoading && viewModel.organizations.isEmpty {
                    LoadingOverlay(text: "Loading offers...")
                }
            }
        }
        .navigationTitle("Partners")
        .toolbarColorScheme(.light, for: .navigationBar)
        .background(Color.colorGray200)
        .task {
            await viewModel.loadInitialData()
        }
        .alert(
            "Error",
            isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )
        ) {
            Button("Retry") {
                Task { await viewModel.loadData() }
            }
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "An unknown error occurred")
        }
    }

    // MARK: - Helper View
    //TODO: - ამის გაჯენერიქებაც შეიძლება ვიუბილდერით, ოფერების ლისტიც მსაგვსია
    private var resultsListView: some View {
        VStack {
            FoundResultsText(
                text: "\(viewModel.organizations.count) organizations found"
            )
            ScrollView {
                LazyVStack(spacing: 16) {
                    OrganizationsList(organizations: viewModel.organizations) {
                        organizationPageId,
                        organizationItemId in
                        router.openOrganization(
                            organizationPageId: organizationPageId,
                            organizationItemId: organizationItemId
                        )
                    }
                    if viewModel.canLoadMore {
                        AppButton(
                            title: "Load More",
                            isLoading: viewModel.isLoading
                        ) {
                            viewModel.loadNextPage()
                        }
                    }
                }
                .padding(.vertical, 16)
            }
        }
    }

}

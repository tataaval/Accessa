//
//  OffersListView.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI

struct OffersListView: View {
    // MARK: - StateObject
    @StateObject private var viewModel: OffersListViewModel

    // MARK: - Properties
    let router: OffersRouter

    // MARK: - Init
    init(router: OffersRouter) {
        self.router = router
        _viewModel = StateObject(
            wrappedValue: OffersListViewModel(
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
                    placeholder: "Search offers..."
                )
                .padding(.horizontal)

                CategoriesSection(
                    categories: viewModel.categories,
                    selectedCategoryId: viewModel.selectedCategoryId
                ) { id in
                    viewModel.selectCategory(id: id)
                }
            }
            Divider()
            ZStack {
                if !viewModel.offers.isEmpty {
                    resultsListView
                } else if !viewModel.isLoading {
                    EmptyStateText(text: "No Offers Found")
                }

                if viewModel.isLoading && viewModel.offers.isEmpty {
                    LoadingOverlay(text: "Loading offers...")
                }
            }
        }
        .navigationTitle("All Offers")
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
    private var resultsListView: some View {
        VStack {
            FoundResultsText(text: "\(viewModel.offers.count) offers found")
            ScrollView {
                LazyVStack(spacing: 16) {
                    OffersList(offers: viewModel.offers) { id in
                        router.openOffer(id: id)
                    }
                    if viewModel.canLoadMore {
                        LoadMoreButton(
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

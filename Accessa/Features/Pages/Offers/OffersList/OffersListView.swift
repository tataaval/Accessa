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
            headerSection
            Divider()
            ZStack {
                if !viewModel.offers.isEmpty {
                    resultsListView
                }
                else if !viewModel.isLoading {
                    emptyStateView
                }
                
                if viewModel.isLoading && viewModel.offers.isEmpty {
                    initialLoadingView
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

    // MARK: - Helper Views
    private var headerSection: some View {
        VStack(spacing: 12) {
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
        .padding(.vertical, 12)
        .background(Color.white)
    }

    private var resultsListView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                HStack {
                    Text("\(viewModel.offers.count) offers found")
                        .font(.app(size: .sm, weight: .semibold))
                        .foregroundStyle(.colorPrimary)
                    Spacer()
                }
                .padding(.horizontal)

                OffersList(offers: viewModel.offers) { id in
                    router.openOffer(id: id)
                }
                if viewModel.canLoadMore {
                    loadMoreButtonView
                }
            }
            .padding(.vertical, 16)
        }
    }

    private var loadMoreButtonView: some View {
        Button {
            viewModel.loadNextPage()
        } label: {
            ZStack {
                Text("Load more")
                    .font(.app(size: .lg, weight: .semibold))
                    .opacity(viewModel.isLoading ? 0 : 1)

                if viewModel.isLoading {
                    ProgressView().tint(.white)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 54)
        }
        .background(Color.colorPrimary)
        .foregroundStyle(.white)
        .cornerRadius(12)
        .padding(.horizontal)
        .disabled(viewModel.isLoading)
    }

    private var initialLoadingView: some View {
        VStack {
            ProgressView().scaleEffect(1.2)
            Text("Loading offers...")
                .font(.app(size: .sm))
                .foregroundColor(.gray)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.colorGray200)
    }

    private var emptyStateView: some View {
        Text("No offers found")
            .font(.app(size: .lg, weight: .semibold))
            .foregroundStyle(.colorPrimary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

}

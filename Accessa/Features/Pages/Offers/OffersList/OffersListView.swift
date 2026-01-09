//
//  OffersListView.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI

struct OffersListView: View {
    //MARK: - StateObject
    @StateObject private var viewModel: OffersListViewModel

    //MARK: - Properties
    let router: OffersRouter

    //MARK: - Init
    init(router: OffersRouter) {
        self.router = router
        _viewModel = StateObject(
            wrappedValue: OffersListViewModel(
                networkService: NetworkService.shared
            )
        )
    }

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
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
            Divider()
            if !viewModel.offers.isEmpty {
                Text("\(viewModel.offers.count) offers found")
                    .font(.app(size: .sm, weight: .semibold))
                    .foregroundStyle(.colorPrimary)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
            }
            ScrollView {
                content
            }
        }
        .navigationTitle("All Offers")
        .toolbarColorScheme(.light, for: .navigationBar)
        .background(.colorGray200)
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
                Task {
                    await viewModel.loadData()
                }
            }
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "An unknown error occurred")
        }
    }

    //MARK: - Helper View
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && viewModel.offers.isEmpty {
            ProgressView()
                .frame(maxWidth: .infinity)
        } else if viewModel.offers.isEmpty && !viewModel.isLoading {
            Text("No offers found")
                .font(.app(size: .lg, weight: .semibold))
                .foregroundStyle(.colorPrimary)
                .frame(maxWidth: .infinity)
                .padding(.top, 40)
        } else {
            VStack(spacing: 16) {
                OffersList(offers: viewModel.offers) { id in
                    router.openOffer(id: id)
                }

                if viewModel.canLoadMore {
                    Button {
                        viewModel.loadNextPage()
                    } label: {
                        if viewModel.isLoading {
                            ProgressView()
                                .padding()
                        } else {
                            Text("Load more")
                                .font(.app(size: .lg, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                    }
                    .disabled(viewModel.isLoading)
                    .background(.colorPrimary)
                    .foregroundStyle(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
        }
    }
}

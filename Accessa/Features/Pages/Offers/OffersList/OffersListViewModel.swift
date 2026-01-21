//
//  OffersListViewModel.swift
//  Accessa
//
//  Created by Tatarella on 09.01.26.
//

import Combine
import Foundation

final class OffersListViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var offers: [OfferModel] = []
    @Published var categories: [CategoryModel] = []

    @Published var searchText: String = ""
    @Published var selectedCategoryId: Int?

    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published private var meta: PaginationMetaModel?

    // MARK: - Private Properties
    private let offersService: OffersServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1

    //MARK: - Calculated Properties
    var canLoadMore: Bool {
        guard let meta else { return false }
        return meta.hasNextPage && !isLoading
    }

    // MARK: - Init
    init(offersService: OffersServiceProtocol = OffersService()) {
        self.offersService = offersService
        bindSearch()
    }

    // MARK: - Load Functions
    func loadInitialData() async {
        guard offers.isEmpty else { return }

        isLoading = true
        errorMessage = nil

        do {
            async let categoriesTask = fetchCategories()
            async let offersTask = fetchOffers(reset: true)

            let (fetchedCategories, fetchedOffers) = try await (
                categoriesTask, offersTask
            )

            self.categories = fetchedCategories
            self.offers = fetchedOffers
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func loadData(reset: Bool = true) async {
        guard !isLoading else { return }

        if reset {
            currentPage = 1
            offers.removeAll()
        }

        isLoading = true
        errorMessage = nil

        do {
            let newOffers = try await fetchOffers(reset: reset)
            if reset {
                offers = newOffers
            } else {
                offers.append(contentsOf: newOffers)
            }
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    private func fetchOffers(reset: Bool) async throws -> [OfferModel] {
        let page = reset ? 1 : currentPage

        let response = try await offersService.fetchOffers(
                    page: page,
                    limit: 12,
                    search: searchText.isEmpty ? nil : searchText,
                    categoryId: selectedCategoryId
                )

        meta = response.meta
        currentPage = response.meta.currentPage + 1

        return response.data
    }

    private func fetchCategories() async throws -> [CategoryModel] {
        try await offersService.fetchCategories()
    }

    //MARK: - textfield binding
    private func bindSearch() {
        $searchText
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self else { return }
                if text.isEmpty {
                    Task { await self.loadData(reset: true) }
                    return
                }
                guard text.count >= 3 else { return }
                Task { await self.loadData(reset: true) }
            }
            .store(in: &cancellables)
    }

    //MARK: - Helper functions
    func selectCategory(id: Int?) {
        if id == -1 {
            selectedCategoryId = nil
        } else {
            selectedCategoryId = id
        }
        Task {
            await loadData()
        }
    }

    func loadNextPage() {
        guard canLoadMore else { return }

        Task {
            await loadData(reset: false)
        }
    }
}


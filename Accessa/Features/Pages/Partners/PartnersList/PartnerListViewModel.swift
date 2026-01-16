//
//  PartnerListViewModel.swift
//  Accessa
//
//  Created by Tatarella on 11.01.26.
//

import Combine
import Foundation

final class PartnerListViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var organizations: [OrganizationItemModel] = []

    @Published var searchText: String = ""

    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published private var meta: PaginationMetaModel?

    // MARK: - Private Properties
    private let networkService: NetworkServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1

    //MARK: - Calculated Properties
    var canLoadMore: Bool {
        guard let meta else { return false }
        return meta.hasNextPage && !isLoading
    }

    // MARK: - Init
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        bindSearch()
    }

    // MARK: - Load Functions
    func loadInitialData() async {
        guard organizations.isEmpty else { return }

        isLoading = true
        errorMessage = nil

        do {
            async let organizationsTask = fetchOrganizations(reset: true)

            let organizationsResult = try await organizationsTask
            self.organizations = organizationsResult

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func loadData(reset: Bool = true) async {
        guard !isLoading else { return }

        if reset {
            currentPage = 1
            organizations.removeAll()
        }

        isLoading = true
        errorMessage = nil

        do {
            let newOrganizations = try await fetchOrganizations(reset: reset)
            if reset {
                organizations = newOrganizations
            } else {
                organizations.append(contentsOf: newOrganizations)
            }
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    private func fetchOrganizations(reset: Bool) async throws
        -> [OrganizationItemModel]
    {
        let page = reset ? 1 : currentPage

        let response: OrganizationsResponseModel =
            try await networkService.fetch(
                from: API.organizations(
                    limit: 12,
                    page: page,
                    searchKeyword: searchText.isEmpty ? nil : searchText,
                )
            )

        meta = response.meta
        currentPage = response.meta.currentPage + 1

        return response.data
    }

    //MARK: - textfield binding
    private func bindSearch() {
        $searchText
            .removeDuplicates()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                guard let self else { return }
                Task {
                    await self.loadData()
                }
            }
            .store(in: &cancellables)
    }

    //MARK: - Helper functions
    func loadNextPage() {
        guard canLoadMore else { return }

        Task {
            await loadData(reset: false)
        }
    }

}

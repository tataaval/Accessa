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
    private let partnerService: PartnerServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1

    //MARK: - Calculated Properties
    var canLoadMore: Bool {
        guard let meta else { return false }
        return meta.hasNextPage && !isLoading
    }

    // MARK: - Init
    init(partnerService: PartnerServiceProtocol) {
        self.partnerService = partnerService
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

        let response = try await partnerService.fetchOrganizations(
            page: page,
            limit: 12,
            search: searchText.isEmpty ? nil : searchText
        )

        self.meta = response.meta
        self.currentPage = response.meta.currentPage + 1

        return response.data
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
    func loadNextPage() {
        guard canLoadMore else { return }

        Task {
            await loadData(reset: false)
        }
    }
}
